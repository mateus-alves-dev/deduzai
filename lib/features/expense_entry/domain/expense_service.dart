import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'expense_service.g.dart';

@riverpod
ExpenseService expenseService(Ref ref) =>
    ExpenseService(ref.watch(expenseDaoProvider));

class ExpenseService {
  ExpenseService(this._dao);

  final ExpenseDao _dao;
  static const _uuid = Uuid();

  Future<void> createExpense({
    required DateTime date,
    required DeductionCategory category,
    required int amountInCents,
    required String description,
    String? beneficiario,
  }) async {
    final now = DateTime.now();
    await _dao.insertExpense(
      db.ExpensesCompanion.insert(
        id: _uuid.v4(),
        date: date,
        category: category.name,
        amountInCents: amountInCents,
        description: description,
        origem: Value(ExpenseOrigem.manual.value),
        beneficiario: Value(beneficiario),
        createdAt: now,
      ),
    );
  }

  Future<void> updateExpense({
    required db.Expense existing,
    required DateTime date,
    required DeductionCategory category,
    required int amountInCents,
    required String description,
    String? beneficiario,
  }) async {
    await _dao.updateExpense(
      db.ExpensesCompanion(
        id: Value(existing.id),
        date: Value(date),
        category: Value(category.name),
        amountInCents: Value(amountInCents),
        description: Value(description),
        beneficiario: Value(beneficiario),
        receiptPath: Value(existing.receiptPath),
        origem: Value(existing.origem),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        deletedAt: const Value(null),
      ),
    );
  }

  Future<void> deleteExpense(String id) => _dao.softDelete(id);
}
