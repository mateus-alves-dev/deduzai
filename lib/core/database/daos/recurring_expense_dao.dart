import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/recurring_expenses_table.dart';
import 'package:drift/drift.dart';

part 'recurring_expense_dao.g.dart';

@DriftAccessor(tables: [RecurringExpenses])
class RecurringExpenseDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringExpenseDaoMixin {
  RecurringExpenseDao(super.db);

  Stream<List<RecurringExpense>> watchAll() =>
      (select(recurringExpenses)
            ..where((r) => r.deletedAt.isNull())
            ..orderBy([(r) => OrderingTerm.asc(r.description)]))
          .watch();

  Stream<List<RecurringExpense>> watchDue(DateTime asOf) =>
      (select(recurringExpenses)
            ..where(
              (r) =>
                  r.deletedAt.isNull() &
                  r.isActive.equals(true) &
                  r.nextDueDate.isSmallerOrEqualValue(asOf),
            )
            ..orderBy([(r) => OrderingTerm.asc(r.nextDueDate)]))
          .watch();

  Future<void> insertRecurringExpense(RecurringExpensesCompanion entry) =>
      into(recurringExpenses).insert(entry);

  Future<bool> updateRecurringExpense(RecurringExpensesCompanion entry) =>
      update(recurringExpenses).replace(entry);

  Future<void> updateNextDueDate(String id, DateTime nextDue) =>
      (update(recurringExpenses)..where((r) => r.id.equals(id))).write(
        RecurringExpensesCompanion(
          nextDueDate: Value(nextDue),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> setActive(String id, {required bool active}) =>
      (update(recurringExpenses)..where((r) => r.id.equals(id))).write(
        RecurringExpensesCompanion(
          isActive: Value(active),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> softDelete(String id) =>
      (update(recurringExpenses)..where((r) => r.id.equals(id))).write(
        RecurringExpensesCompanion(
          deletedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<RecurringExpense?> getById(String id) =>
      (select(recurringExpenses)
            ..where((r) => r.id.equals(id))
            ..where((r) => r.deletedAt.isNull()))
          .getSingleOrNull();
}
