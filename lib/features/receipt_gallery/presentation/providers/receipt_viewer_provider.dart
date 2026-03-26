import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/providers/stream_provider.dart';

/// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
final StreamProviderFamily<List<Receipt>, String> receiptsByExpenseProvider =
    StreamProvider.family<List<Receipt>, String>(
      (ref, expenseId) =>
          ref.watch(receiptDaoProvider).watchByExpenseId(expenseId),
    );

/// Streams the parent expense for metadata display (Spec 4.1).
final StreamProviderFamily<Expense?, String> receiptViewerExpenseProvider =
    StreamProvider.family<Expense?, String>(
      (ref, expenseId) => ref.watch(expenseDaoProvider).watchById(expenseId),
    );

/// Streams receipts of soft-deleted expenses (Spec 4.4).
final archivedReceiptsWithExpenseProvider =
    StreamProvider<List<({Receipt receipt, Expense expense})>>(
      (ref) => ref.watch(receiptDaoProvider).watchArchivedReceiptsWithExpense(),
    );
