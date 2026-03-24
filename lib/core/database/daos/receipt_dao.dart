import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/receipts_table.dart';
import 'package:drift/drift.dart';

part 'receipt_dao.g.dart';

@DriftAccessor(tables: [Receipts])
class ReceiptDao extends DatabaseAccessor<AppDatabase>
    with _$ReceiptDaoMixin {
  ReceiptDao(super.db);

  Future<void> insertReceipt(ReceiptsCompanion entry) =>
      into(receipts).insert(entry);

  Stream<List<Receipt>> watchByExpenseId(String expenseId) =>
      (select(receipts)..where((r) => r.expenseId.equals(expenseId))).watch();

  Future<Receipt?> findById(String id) =>
      (select(receipts)..where((r) => r.id.equals(id))).getSingleOrNull();
}
