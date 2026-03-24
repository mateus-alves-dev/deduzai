import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'receipt_viewer_provider.g.dart';

/// Streams receipts linked to [expenseId] (Spec 4.1 / 4.2).
@riverpod
Stream<List<Receipt>> receiptsByExpense(Ref ref, String expenseId) =>
    ref.watch(receiptDaoProvider).watchByExpenseId(expenseId);

/// Streams the parent expense for metadata display (Spec 4.1).
@riverpod
Stream<Expense?> receiptViewerExpense(Ref ref, String expenseId) =>
    ref.watch(expenseDaoProvider).watchById(expenseId);

/// Streams receipts of soft-deleted expenses (Spec 4.4).
@riverpod
Stream<List<({Receipt receipt, Expense expense})>>
    archivedReceiptsWithExpense(Ref ref) =>
        ref.watch(receiptDaoProvider).watchArchivedReceiptsWithExpense();
