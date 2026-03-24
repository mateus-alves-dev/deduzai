import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:drift/drift.dart';

part 'expense_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpenseDao extends DatabaseAccessor<AppDatabase> with _$ExpenseDaoMixin {
  ExpenseDao(super.db);

  Future<List<Expense>> getAll() =>
      (select(expenses)..where((e) => e.deletedAt.isNull())).get();

  Stream<List<Expense>> watchAll() =>
      (select(expenses)..where((e) => e.deletedAt.isNull())).watch();

  Stream<List<Expense>> watchByYear(int year) {
    final start = DateTime(year);
    final end = DateTime(year + 1);
    return (select(expenses)
          ..where(
            (e) =>
                e.deletedAt.isNull() &
                e.date.isBiggerOrEqualValue(start) &
                e.date.isSmallerThanValue(end),
          )
          ..orderBy([(e) => OrderingTerm.desc(e.date)]))
        .watch();
  }

  Future<void> insertExpense(ExpensesCompanion entry) =>
      into(expenses).insert(entry);

  Future<bool> updateExpense(ExpensesCompanion entry) =>
      update(expenses).replace(entry);

  Future<void> softDelete(String id) {
    return (update(expenses)..where((e) => e.id.equals(id))).write(
      ExpensesCompanion(
        updatedAt: Value(DateTime.now()),
        deletedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<Expense?> watchById(String id) =>
      (select(expenses)
            ..where((e) => e.id.equals(id))
            ..where((e) => e.deletedAt.isNull()))
          .watchSingleOrNull();
}
