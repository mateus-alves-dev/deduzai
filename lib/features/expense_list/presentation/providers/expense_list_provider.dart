import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseListProvider = StreamProvider<List<Expense>>((ref) =>
    ref.watch(expenseDaoProvider).watchByYear(DateTime.now().year));

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
final expenseHasReceiptProvider =
    StreamProvider.family<bool, String>((ref, expenseId) => ref
        .watch(receiptDaoProvider)
        .watchByExpenseId(expenseId)
        .map((list) => list.isNotEmpty));
