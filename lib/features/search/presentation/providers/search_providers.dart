import 'dart:async';

import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/search_filter.dart';
import 'package:deduzai/features/search/domain/search_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Favorites stream ─────────────────────────────────────────────────────────

final filterFavoritesProvider = StreamProvider<List<FilterFavorite>>(
  (ref) => ref.watch(filterFavoriteDaoProvider).watchAll(),
);

// ── Active filter state ───────────────────────────────────────────────────────

final searchNotifierProvider =
    NotifierProvider<SearchNotifier, SearchFilter>(SearchNotifier.new);

class SearchNotifier extends Notifier<SearchFilter> {
  Timer? _debounce;

  @override
  SearchFilter build() => const SearchFilter();

  void setQuery(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      state = state.copyWith(query: q);
    });
  }

  void setCategories(List<DeductionCategory> cats) =>
      state = state.copyWith(categories: cats);

  void setDateFrom(DateTime? d) => state = state.copyWith(dateFrom: d);

  void setDateTo(DateTime? d) => state = state.copyWith(dateTo: d);

  void setAmountRange(int? min, int? max) =>
      state = state.copyWith(amountMinCents: min, amountMaxCents: max);

  void setReceiptFilter(SearchReceiptFilter r) =>
      state = state.copyWith(receiptFilter: r);

  void setSortOrder(SearchSortOrder s) => state = state.copyWith(sortOrder: s);

  void clearAll() => state = const SearchFilter();

  void applyFavorite(FilterFavorite fav) {
    final cats = fav.categorias == null
        ? <DeductionCategory>[]
        : _parseCats(fav.categorias!);

    state = SearchFilter(
      categories: cats,
      dateFrom: fav.dataInicio,
      dateTo: fav.dataFim,
      amountMinCents: fav.valorMin,
      amountMaxCents: fav.valorMax,
      receiptFilter: fav.comComprovante == null
          ? SearchReceiptFilter.all
          : fav.comComprovante!
              ? SearchReceiptFilter.withReceipt
              : SearchReceiptFilter.withoutReceipt,
    );
  }

  static List<DeductionCategory> _parseCats(String json) {
    final cleaned = json.replaceAll(RegExp('[\\[\\]"]'), '').trim();
    if (cleaned.isEmpty) return [];
    return cleaned
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map(
          (name) => DeductionCategory.values.firstWhere(
            (c) => c.name == name,
            orElse: () => DeductionCategory.saude,
          ),
        )
        .toList();
  }
}

// ── Search results (recomputes on filter change) ─────────────────────────────

final searchResultsProvider = FutureProvider.autoDispose<List<Expense>>((ref) {
  final filter = ref.watch(searchNotifierProvider);
  return ref.read(searchServiceProvider).searchExpenses(filter);
});
