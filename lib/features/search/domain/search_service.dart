import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/search_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_service.g.dart';

@riverpod
SearchService searchService(Ref ref) => SearchService(
      ref.watch(expenseDaoProvider),
      ref.watch(receiptDaoProvider),
    );

class SearchService {
  const SearchService(this._expenseDao, this._receiptDao);

  final ExpenseDao _expenseDao;
  final ReceiptDao _receiptDao;

  Future<List<Expense>> searchExpenses(SearchFilter filter) async {
    final results = await _expenseDao.searchFiltered(
      categories: filter.categories.isEmpty
          ? null
          : filter.categories.map((c) => c.name).toList(),
      dateFrom: filter.dateFrom,
      dateTo: filter.dateTo,
      amountMin: filter.amountMinCents,
      amountMax: filter.amountMaxCents,
      sort: filter.sortOrder,
    );

    List<Expense> filtered = results;

    if (filter.query.isNotEmpty) {
      final q = normalizeText(filter.query);
      filtered = filtered
          .where(
            (Expense e) =>
                normalizeText(e.description).contains(q) ||
                normalizeText(e.beneficiario ?? '').contains(q),
          )
          .toList();
    }

    if (filter.receiptFilter != SearchReceiptFilter.all) {
      final idsWithReceipt = await _getExpenseIdsWithReceipt(
        filtered.map((Expense e) => e.id).toList(),
      );
      filtered = filtered.where((Expense e) {
        final has = idsWithReceipt.contains(e.id);
        return filter.receiptFilter == SearchReceiptFilter.withReceipt
            ? has
            : !has;
      }).toList();
    }

    return filtered;
  }

  Future<Set<String>> _getExpenseIdsWithReceipt(List<String> ids) async {
    final result = <String>{};
    for (final id in ids) {
      final receipts = await _receiptDao.watchByExpenseId(id).first;
      if (receipts.isNotEmpty) result.add(id);
    }
    return result;
  }

  static String normalizeText(String text) => text
      .toLowerCase()
      .replaceAll(RegExp('[àáâãä]'), 'a')
      .replaceAll(RegExp('[èéêë]'), 'e')
      .replaceAll(RegExp('[ìíîï]'), 'i')
      .replaceAll(RegExp('[òóôõö]'), 'o')
      .replaceAll(RegExp('[ùúûü]'), 'u')
      .replaceAll(RegExp('[ç]'), 'c');
}
