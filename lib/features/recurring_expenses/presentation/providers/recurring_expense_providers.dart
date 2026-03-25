import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// All non-deleted templates (management screen).
final recurringExpenseListProvider = StreamProvider<List<RecurringExpense>>(
  (ref) => ref.watch(recurringExpenseDaoProvider).watchAll(),
);

/// Templates whose nextDueDate <= today (drives banner + bottom sheet).
final dueRecurringExpensesProvider = StreamProvider<List<RecurringExpense>>(
  (ref) => ref.watch(recurringExpenseDaoProvider).watchDue(DateTime.now()),
);

/// Count of due templates for the banner badge.
final dueRecurringExpensesCountProvider = Provider<int>(
  (ref) => ref.watch(dueRecurringExpensesProvider).value?.length ?? 0,
);
