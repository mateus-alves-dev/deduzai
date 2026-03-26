import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/features/annual_summary/domain/annual_summary_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthly_summary_service.g.dart';

@riverpod
MonthlySummaryService monthlySummaryService(Ref ref) =>
    MonthlySummaryService(ref.watch(annualSummaryServiceProvider));

class MonthlySummary {
  const MonthlySummary({
    required this.year,
    required this.month,
    required this.categories,
    required this.ytdCategories,
    required this.totalInCents,
    required this.prevMonthTotalInCents,
    this.percentChangeVsPrev,
  });

  final int year;
  final int month;

  /// Category summaries for the selected month only.
  final List<CategorySummary> categories;

  /// Category summaries from Jan to selected month (for YTD cap display).
  final List<CategorySummary> ytdCategories;

  final int totalInCents;
  final int prevMonthTotalInCents;

  /// Percentage change vs previous month, null if no previous data.
  final double? percentChangeVsPrev;

  bool get isEmpty => categories.isEmpty;
}

class MonthlySummaryService {
  const MonthlySummaryService(this._annualService);

  final AnnualSummaryService _annualService;

  MonthlySummary computeMonthly({
    required List<Expense> monthExpenses,
    required List<Expense> prevMonthExpenses,
    required List<Expense> yearToDateExpenses,
    required int year,
    required int month,
  }) {
    final monthlySummary = _annualService.computeSync(monthExpenses, year);
    final ytdSummary = _annualService.computeSync(yearToDateExpenses, year);

    final currentTotal = monthExpenses.fold(0, (s, e) => s + e.amountInCents);
    final prevTotal = prevMonthExpenses.fold(0, (s, e) => s + e.amountInCents);
    final percentChange = prevTotal > 0
        ? (currentTotal - prevTotal) / prevTotal * 100
        : null;

    return MonthlySummary(
      year: year,
      month: month,
      categories: monthlySummary.categories,
      ytdCategories: ytdSummary.categories,
      totalInCents: currentTotal,
      prevMonthTotalInCents: prevTotal,
      percentChangeVsPrev: percentChange,
    );
  }
}
