import 'dart:io';

import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:deduzai/core/database/tables/receipts_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Expenses, Receipts],
  daos: [ExpenseDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'deduzai.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
