import 'dart:io';

import 'package:deduzai/core/database/daos/app_settings_dao.dart';
import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/daos/dependents_dao.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/filter_favorite_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:deduzai/core/database/daos/recurring_expense_dao.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:deduzai/core/database/tables/cnpj_preferences_table.dart';
import 'package:deduzai/core/database/tables/dependents_table.dart';
import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:deduzai/core/database/tables/filter_favorites_table.dart';
import 'package:deduzai/core/database/tables/receipts_table.dart';
import 'package:deduzai/core/database/tables/recurring_expenses_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Expenses,
    Receipts,
    CnpjPreferences,
    AppSettings,
    RecurringExpenses,
    FilterFavorites,
    Dependents,
  ],
  daos: [
    ExpenseDao,
    ReceiptDao,
    CnpjPreferenceDao,
    AppSettingsDao,
    RecurringExpenseDao,
    FilterFavoriteDao,
    DependentsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 11;

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
      if (from < 5) {
        await m.createTable(appSettings);
      }
      if (from < 6) {
        await m.addColumn(cnpjPreferences, cnpjPreferences.beneficiario);
      }
      if (from < 7) {
        await m.addColumn(cnpjPreferences, cnpjPreferences.cnaeDescricao);
      }
      if (from < 8) {
        await m.createTable(recurringExpenses);
      }
      if (from < 9) {
        await m.createTable(filterFavorites);
      }
      if (from < 10) {
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses(date)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_expenses_deleted_at '
          'ON expenses(deleted_at)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_expenses_category '
          'ON expenses(category)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_receipts_expense_id '
          'ON receipts(expense_id)',
        );
      }
      if (from < 11) {
        await m.createTable(dependents);
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
