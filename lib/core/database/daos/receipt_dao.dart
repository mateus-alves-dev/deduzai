import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:deduzai/core/database/tables/receipts_table.dart';
import 'package:drift/drift.dart';

part 'receipt_dao.g.dart';

@DriftAccessor(tables: [Receipts, Expenses])
class ReceiptDao extends DatabaseAccessor<AppDatabase>
    with _$ReceiptDaoMixin {
  ReceiptDao(super.db);

  Future<void> insertReceipt(ReceiptsCompanion entry) =>
      into(receipts).insert(entry);

  Stream<List<Receipt>> watchByExpenseId(String expenseId) =>
      (select(receipts)..where((r) => r.expenseId.equals(expenseId))).watch();

  Future<Receipt?> findById(String id) =>
      (select(receipts)..where((r) => r.id.equals(id))).getSingleOrNull();

  /// Returns the set of expense IDs that have at least one receipt.
  Future<Set<String>> getExpenseIdsWithReceipts(List<String> ids) async {
    if (ids.isEmpty) return {};
    final rows = await (select(receipts)
          ..where((r) => r.expenseId.isIn(ids)))
        .get();
    return rows.map((r) => r.expenseId).toSet();
  }

  /// Watches a set of all expense IDs that have at least one receipt.
  /// Single stream replaces N per-expense streams for list rendering.
  Stream<Set<String>> watchAllExpenseIdsWithReceipts() {
    final query = selectOnly(receipts, distinct: true)
      ..addColumns([receipts.expenseId]);
    return query
        .map((row) => row.read(receipts.expenseId)!)
        .watch()
        .map((list) => list.toSet());
  }

  /// Returns receipts belonging to soft-deleted expenses (Spec 4.4).
  Stream<List<({Receipt receipt, Expense expense})>>
      watchArchivedReceiptsWithExpense() {
    final query = select(receipts).join([
      innerJoin(expenses, expenses.id.equalsExp(receipts.expenseId)),
    ])
      ..where(expenses.deletedAt.isNotNull())
      ..orderBy([OrderingTerm.desc(receipts.createdAt)]);

    return query
        .map(
          (row) => (
            receipt: row.readTable(receipts),
            expense: row.readTable(expenses),
          ),
        )
        .watch();
  }
}
