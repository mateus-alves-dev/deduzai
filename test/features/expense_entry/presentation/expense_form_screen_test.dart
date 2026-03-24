import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_theme.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:deduzai/features/expense_entry/presentation/screens/expense_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/test_database.dart';

GoRouter _formRouter({String? expenseId}) {
  return GoRouter(
    initialLocation: expenseId != null ? '/form/$expenseId' : '/form',
    routes: [
      GoRoute(path: '/form', builder: (_, __) => const ExpenseFormScreen()),
      GoRoute(
        path: '/form/:id',
        builder: (_, state) =>
            ExpenseFormScreen(expenseId: state.pathParameters['id']),
      ),
    ],
  );
}

extension on WidgetTester {
  Future<void> pumpForm(List<Override> overrides, {String? expenseId}) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: _formRouter(expenseId: expenseId),
        ),
      ),
    );
    await pumpAndSettle();
  }
}

void main() {
  group('ExpenseFormScreen', () {
    final db = createTestDatabase();

    tearDownAll(db.close);

    final overrides = [databaseProvider.overrideWithValue(db)];

    group('Spec 1.1 — new expense', () {
      testWidgets('shows "Novo Gasto" title', (tester) async {
        await tester.pumpForm(overrides);

        expect(find.text('Novo Gasto'), findsOneWidget);
      });

      testWidgets('no category is pre-selected', (tester) async {
        await tester.pumpForm(overrides);

        // DropdownButtonFormField with null value shows no selected item label
        expect(find.text('Saúde'), findsNothing);
        expect(find.text('Educação'), findsNothing);
      });

      testWidgets('delete button is absent in create mode', (tester) async {
        await tester.pumpForm(overrides);

        expect(find.byIcon(Icons.delete_outline), findsNothing);
      });
    });

    group('Spec 1.3 — invalid valor', () {
      testWidgets('shows error when amount is empty', (tester) async {
        await tester.pumpForm(overrides);

        await tester.tap(find.text('Salvar'));
        await tester.pump();

        expect(find.text('Informe um valor maior que zero'), findsOneWidget);
      });

      testWidgets('shows error when amount is zero', (tester) async {
        await tester.pumpForm(overrides);

        await tester.enterText(find.byKey(const Key('amountField')), '0');
        await tester.tap(find.text('Salvar'));
        await tester.pump();

        expect(find.text('Informe um valor maior que zero'), findsOneWidget);
      });
    });

    group('Spec 1.4 — categoria obrigatória', () {
      testWidgets('shows error when no category selected', (tester) async {
        await tester.pumpForm(overrides);

        await tester.enterText(find.byKey(const Key('amountField')), '100');
        await tester.tap(find.text('Salvar'));
        await tester.pump();

        expect(find.text('Selecione uma categoria'), findsOneWidget);
      });
    });

    group('Spec 1.2 — valid save', () {
      setUp(() async {
        final rows = await db.expenseDao.getAll();
        for (final row in rows) {
          await db.expenseDao.softDelete(row.id);
        }
      });

      testWidgets('saves expense to DB with origem MANUAL', (tester) async {
        await tester.pumpForm(overrides);

        await tester.enterText(find.byKey(const Key('amountField')), '125,50');

        // Open category dropdown and select Saúde
        await tester.tap(
          find.byType(DropdownButtonFormField<DeductionCategory>),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Saúde').last);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Salvar'));
        await tester.pumpAndSettle();

        final rows = await db.expenseDao.getAll();
        expect(rows, hasLength(1));
        expect(rows.first.amountInCents, equals(12550));
        expect(rows.first.origem, equals('MANUAL'));
        expect(rows.first.category, equals('saude'));
      });
    });

    group('Spec 1.7 — exclusão', () {
      late String expenseId;

      setUp(() async {
        final rows = await db.expenseDao.getAll();
        for (final row in rows) {
          await db.expenseDao.softDelete(row.id);
        }
        final service = ExpenseService(db.expenseDao, db.receiptDao);
        await service.createExpense(
          date: DateTime.now(),
          category: DeductionCategory.saude,
          amountInCents: 10000,
          description: 'Test expense',
        );
        expenseId = (await db.expenseDao.getAll()).first.id;
      });

      testWidgets('delete icon visible in edit mode', (tester) async {
        await tester.pumpForm(overrides, expenseId: expenseId);

        expect(find.byIcon(Icons.delete_outline), findsOneWidget);
      });

      testWidgets('cancel on delete dialog keeps expense', (tester) async {
        await tester.pumpForm(overrides, expenseId: expenseId);

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        expect(find.text('Excluir gasto?'), findsOneWidget);

        await tester.tap(find.text('Cancelar'));
        await tester.pumpAndSettle();

        final rows = await db.expenseDao.getAll();
        expect(rows, hasLength(1));
      });

      testWidgets('confirm delete soft-deletes the expense', (tester) async {
        await tester.pumpForm(overrides, expenseId: expenseId);

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Excluir'));
        await tester.pumpAndSettle();

        expect(await db.expenseDao.getAll(), isEmpty);
      });
    });
  });
}
