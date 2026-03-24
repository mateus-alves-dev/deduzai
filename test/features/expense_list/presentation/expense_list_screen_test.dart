import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:deduzai/features/expense_list/presentation/screens/expense_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';
import '../../../helpers/test_database.dart';

void main() {
  group('ExpenseListScreen', () {
    late AppDatabase db;

    setUp(() {
      db = createTestDatabase();
    });

    tearDown(() => db.close());

    testWidgets('shows empty state when no expenses', (tester) async {
      final overrides = [databaseProvider.overrideWithValue(db)];
      await tester.pumpApp(const ExpenseListScreen(), overrides: overrides);

      expect(find.text('Nenhum gasto registrado'), findsOneWidget);
      expect(find.text('Toque em "Novo gasto" para começar'), findsOneWidget);
    });

    testWidgets('shows expense tile after inserting', (tester) async {
      final service = ExpenseService(db.expenseDao);
      await service.createExpense(
        date: DateTime.now(),
        category: DeductionCategory.saude,
        amountInCents: 5000,
        description: 'Farmácia',
      );

      final overrides = [databaseProvider.overrideWithValue(db)];
      await tester.pumpApp(const ExpenseListScreen(), overrides: overrides);

      expect(find.text('Farmácia'), findsOneWidget);
      expect(find.textContaining('50'), findsAtLeastNWidgets(1));
    });

    testWidgets('FAB button is present', (tester) async {
      final overrides = [databaseProvider.overrideWithValue(db)];
      await tester.pumpApp(const ExpenseListScreen(), overrides: overrides);

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Novo gasto'), findsOneWidget);
    });
  });
}
