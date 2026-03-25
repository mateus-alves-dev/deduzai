import 'package:deduzai/core/domain/models/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_filter.freezed.dart';

enum SearchSortOrder {
  dateDesc,
  dateAsc,
  amountDesc,
  amountAsc,
  categoryAz,
}

enum SearchReceiptFilter { all, withReceipt, withoutReceipt }

@freezed
abstract class SearchFilter with _$SearchFilter {
  const factory SearchFilter({
    @Default('') String query,
    @Default([]) List<DeductionCategory> categories,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? amountMinCents,
    int? amountMaxCents,
    @Default(SearchReceiptFilter.all) SearchReceiptFilter receiptFilter,
    @Default(SearchSortOrder.dateDesc) SearchSortOrder sortOrder,
  }) = _SearchFilter;

  const SearchFilter._();

  bool get hasActiveFilters =>
      query.isNotEmpty ||
      categories.isNotEmpty ||
      dateFrom != null ||
      dateTo != null ||
      amountMinCents != null ||
      amountMaxCents != null ||
      receiptFilter != SearchReceiptFilter.all ||
      sortOrder != SearchSortOrder.dateDesc;
}
