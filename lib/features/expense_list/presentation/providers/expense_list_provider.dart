import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_list_provider.g.dart';

@riverpod
Stream<List<Expense>> expenseList(Ref ref) =>
    ref.watch(expenseDaoProvider).watchByYear(DateTime.now().year);

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
@riverpod
Stream<bool> expenseHasReceipt(Ref ref, String expenseId) => ref
    .watch(receiptDaoProvider)
    .watchByExpenseId(expenseId)
    .map((list) => list.isNotEmpty);
