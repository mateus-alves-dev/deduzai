import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseListProvider = StreamProvider<List<Expense>>((ref) =>
    ref.watch(expenseDaoProvider).watchByYear(DateTime.now().year));

/// Single stream that tracks ALL expense IDs with receipts.
/// One DB stream replaces N per-tile streams, reducing I/O and rebuilds.
final _receiptExpenseIdsProvider = StreamProvider<Set<String>>((ref) =>
    ref.watch(receiptDaoProvider).watchAllExpenseIdsWithReceipts());

/// Emits true when [expenseId] has at least one receipt attached (Spec 4.2).
/// Backed by a single batch query instead of per-expense streams.
final expenseHasReceiptProvider =
    Provider.family<AsyncValue<bool>, String>((ref, expenseId) =>
        ref.watch(_receiptExpenseIdsProvider).whenData(
              (ids) => ids.contains(expenseId),
            ));
