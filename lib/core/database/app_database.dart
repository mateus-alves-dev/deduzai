import 'dart:io';

import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:deduzai/core/database/tables/cnpj_preferences_table.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:deduzai/core/database/tables/receipts_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Expenses, Receipts, CnpjPreferences],
  daos: [ExpenseDao, ReceiptDao, CnpjPreferenceDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(expenses, expenses.beneficiario);
        await m.addColumn(expenses, expenses.origem);
      }
      if (from < 3) {
        await m.addColumn(expenses, expenses.cnpj);
        await m.addColumn(receipts, receipts.mimeType);
        await m.addColumn(receipts, receipts.tamanhoBytes);
        await m.addColumn(receipts, receipts.ocrStatus);
      }
      if (from < 4) {
        await m.createTable(cnpjPreferences);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'deduzai.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
