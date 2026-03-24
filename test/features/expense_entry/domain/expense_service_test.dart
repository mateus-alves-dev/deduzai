import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_database.dart';

void main() {
  group('ExpenseService', () {
    late AppDatabase db;
    late ExpenseService service;

    setUp(() {
      db = createTestDatabase();
      service = ExpenseService(db.expenseDao);
    });

    tearDown(() => db.close());

    group('createExpense', () {
      test('inserts a record with origem = MANUAL', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 15000,
          description: 'Consulta médica',
        );

        final rows = await db.expenseDao.getAll();
        expect(rows, hasLength(1));
        expect(rows.first.origem, equals('MANUAL'));
        expect(rows.first.amountInCents, equals(15000));
        expect(rows.first.category, equals('saude'));
        expect(rows.first.deletedAt, isNull);
      });

      test('stores null beneficiario when not provided', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.educacao,
          amountInCents: 50000,
          description: 'Mensalidade',
        );

        final rows = await db.expenseDao.getAll();
        expect(rows.first.beneficiario, isNull);
      });

      test('stores beneficiario when provided', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 8900,
          description: 'Dentista',
          beneficiario: 'Dr. Silva',
        );

        final rows = await db.expenseDao.getAll();
        expect(rows.first.beneficiario, equals('Dr. Silva'));
      });

      test('generates a UUID id', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 100,
          description: '',
        );

        final rows = await db.expenseDao.getAll();
        expect(rows.first.id, isNotEmpty);
        expect(rows.first.id.length, 36);
      });
    });

    group('updateExpense', () {
      test('updates fields and sets updatedAt', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 100,
          description: 'original',
        );
        final original = (await db.expenseDao.getAll()).first;

        await service.updateExpense(
          existing: original,
          date: original.date,
          category: DeductionCategory.educacao,
          amountInCents: 200,
          description: 'updated',
        );

        final updated = (await db.expenseDao.getAll()).first;
        expect(updated.amountInCents, equals(200));
        expect(updated.category, equals('educacao'));
        expect(updated.description, equals('updated'));
        expect(updated.updatedAt, isNotNull);
      });

      test('preserves createdAt and origem', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 100,
          description: '',
        );
        final original = (await db.expenseDao.getAll()).first;

        await service.updateExpense(
          existing: original,
          date: original.date,
          category: DeductionCategory.educacao,
          amountInCents: 200,
          description: 'changed',
        );

        final updated = (await db.expenseDao.getAll()).first;
        expect(updated.createdAt, equals(original.createdAt));
        expect(updated.origem, equals('MANUAL'));
      });
    });

    group('deleteExpense', () {
      test('soft-deletes; expense disappears from getAll()', () async {
        await service.createExpense(
          date: DateTime(2026, 3, 1),
          category: DeductionCategory.saude,
          amountInCents: 100,
          description: '',
        );
        final id = (await db.expenseDao.getAll()).first.id;

        await service.deleteExpense(id);

        expect(await db.expenseDao.getAll(), isEmpty);
      });
    });
  });
}
