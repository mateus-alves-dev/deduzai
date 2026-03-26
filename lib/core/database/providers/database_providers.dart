import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/daos/app_settings_dao.dart';
import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/daos/dependents_dao.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/filter_favorite_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:deduzai/core/database/daos/recurring_expense_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) => AppDatabase();

@Riverpod(keepAlive: true)
ExpenseDao expenseDao(Ref ref) => ref.watch(databaseProvider).expenseDao;

@Riverpod(keepAlive: true)
ReceiptDao receiptDao(Ref ref) => ref.watch(databaseProvider).receiptDao;

@Riverpod(keepAlive: true)
CnpjPreferenceDao cnpjPreferenceDao(Ref ref) =>
    ref.watch(databaseProvider).cnpjPreferenceDao;

@Riverpod(keepAlive: true)
AppSettingsDao appSettingsDao(Ref ref) =>
    ref.watch(databaseProvider).appSettingsDao;

@Riverpod(keepAlive: true)
RecurringExpenseDao recurringExpenseDao(Ref ref) =>
    ref.watch(databaseProvider).recurringExpenseDao;

@Riverpod(keepAlive: true)
FilterFavoriteDao filterFavoriteDao(Ref ref) =>
    ref.watch(databaseProvider).filterFavoriteDao;

@Riverpod(keepAlive: true)
DependentsDao dependentsDao(Ref ref) =>
    ref.watch(databaseProvider).dependentsDao;
