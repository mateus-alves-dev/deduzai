import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_list_provider.g.dart';

@riverpod
Stream<List<Expense>> expenseList(Ref ref) =>
    ref.watch(expenseDaoProvider).watchByYear(DateTime.now().year);
