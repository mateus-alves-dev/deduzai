import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:deduzai/core/domain/models/search_filter.dart';
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

  Future<List<Expense>> searchFiltered({
    List<String>? categories,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? amountMin,
    int? amountMax,
    SearchSortOrder sort = SearchSortOrder.dateDesc,
  }) {
    final q = select(expenses)..where((e) => e.deletedAt.isNull());
    if (categories != null && categories.isNotEmpty) {
      q.where((e) => e.category.isIn(categories));
    }
    if (dateFrom != null) {
      q.where((e) => e.date.isBiggerOrEqualValue(dateFrom));
    }
    if (dateTo != null) {
      q.where((e) => e.date.isSmallerOrEqualValue(dateTo));
    }
    if (amountMin != null) {
      q.where((e) => e.amountInCents.isBiggerOrEqualValue(amountMin));
    }
    if (amountMax != null) {
      q.where((e) => e.amountInCents.isSmallerOrEqualValue(amountMax));
    }
    q.orderBy([_orderingFor(sort)]);
    return q.get();
  }

  OrderingTerm Function(Expenses) _orderingFor(SearchSortOrder sort) =>
      switch (sort) {
        SearchSortOrder.dateDesc => (e) => OrderingTerm.desc(e.date),
        SearchSortOrder.dateAsc => (e) => OrderingTerm.asc(e.date),
        SearchSortOrder.amountDesc =>
          (e) => OrderingTerm.desc(e.amountInCents),
        SearchSortOrder.amountAsc => (e) => OrderingTerm.asc(e.amountInCents),
        SearchSortOrder.categoryAz => (e) => OrderingTerm.asc(e.category),
      };

  Future<List<Expense>> getByMonth(int year, int month) {
    final start = DateTime(year, month);
    final end = DateTime(year, month + 1);
    return (select(expenses)
          ..where(
            (e) =>
                e.deletedAt.isNull() &
                e.date.isBiggerOrEqualValue(start) &
                e.date.isSmallerThanValue(end),
          ))
        .get();
  }

  Future<List<Expense>> getByYearUpToMonth(int year, int month) {
    final start = DateTime(year);
    final end = DateTime(year, month + 1);
    return (select(expenses)
          ..where(
            (e) =>
                e.deletedAt.isNull() &
                e.date.isBiggerOrEqualValue(start) &
                e.date.isSmallerThanValue(end),
          ))
        .get();
  }

  Future<int> countExpensesInMonth(int year, int month) {
    final start = DateTime(year, month);
    final end = DateTime(year, month + 1);
    final countExpr = expenses.id.count();
    return (selectOnly(expenses)
          ..where(
            expenses.deletedAt.isNull() &
                expenses.date.isBiggerOrEqualValue(start) &
                expenses.date.isSmallerThanValue(end),
          )
          ..addColumns([countExpr]))
        .map((row) => row.read(countExpr) ?? 0)
        .getSingle();
  }
}
