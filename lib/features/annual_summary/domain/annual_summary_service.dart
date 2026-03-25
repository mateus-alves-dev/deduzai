import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/deduction_caps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annual_summary_service.g.dart';

@riverpod
AnnualSummaryService annualSummaryService(Ref ref) =>
    const AnnualSummaryService();

/// Top-level function for [compute] — runs [AnnualSummaryService] in a
/// background isolate so the UI thread stays responsive with large datasets.
AnnualSummary _computeInIsolate((List<Expense>, int) args) {
  final (expenses, fiscalYear) = args;
  return const AnnualSummaryService().computeSync(expenses, fiscalYear);
}

/// Aggregates a list of [Expense] rows into an [AnnualSummary], applying
/// deduction caps from [DeductionCaps].
class AnnualSummaryService {
  const AnnualSummaryService();

  /// Computes the summary in a background isolate (use for large datasets).
  Future<AnnualSummary> computeAsync(
    List<Expense> expenses,
    int fiscalYear,
  ) =>
      compute(_computeInIsolate, (expenses, fiscalYear));

  /// Synchronous computation — fine for small datasets (e.g. single month).
  AnnualSummary computeSync(List<Expense> expenses, int fiscalYear) {
    final caps = DeductionCaps.forYear(fiscalYear);

    // Group expenses by DeductionCategory.
    final grouped = <DeductionCategory, List<Expense>>{};
    for (final expense in expenses) {
      final category = _parseCategory(expense.category);
      grouped.putIfAbsent(category, () => []).add(expense);
    }

    var totalInCents = 0;
    var totalDeductibleInCents = 0;
    final summaries = <CategorySummary>[];

    for (final entry in grouped.entries) {
      final category = entry.key;
      final categoryExpenses = entry.value
        ..sort((a, b) => b.date.compareTo(a.date));

      final rawTotal = categoryExpenses.fold(
        0,
        (sum, e) => sum + e.amountInCents,
      );

      final cap = caps[category];
      final deductible = cap != null ? rawTotal.clamp(0, cap) : rawTotal;
      final surplus = (cap != null && rawTotal > cap) ? rawTotal - cap : null;

      summaries.add(
        CategorySummary(
          category: category,
          totalInCents: rawTotal,
          deductibleInCents: deductible,
          capInCents: cap,
          surplusInCents: surplus,
          count: categoryExpenses.length,
          expenses: categoryExpenses,
        ),
      );

      totalInCents += rawTotal;
      totalDeductibleInCents += deductible;
    }

    // Sort summaries by category label for a consistent display order.
    summaries.sort((a, b) => a.category.label.compareTo(b.category.label));

    return AnnualSummary(
      fiscalYear: fiscalYear,
      categories: summaries,
      totalInCents: totalInCents,
      totalDeductibleInCents: totalDeductibleInCents,
    );
  }

  DeductionCategory _parseCategory(String raw) {
    return DeductionCategory.values.firstWhere(
      (c) => c.name == raw,
      orElse: () => DeductionCategory.saude,
    );
  }
}
