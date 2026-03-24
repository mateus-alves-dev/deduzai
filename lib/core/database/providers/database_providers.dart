import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
