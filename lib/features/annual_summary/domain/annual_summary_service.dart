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
AnnualSummary _computeInIsolate((List<Expense>, int, int) args) {
  final (expenses, fiscalYear, dependentCount) = args;
  return const AnnualSummaryService()
      .computeSync(expenses, fiscalYear, dependentCount: dependentCount);
}

/// Aggregates a list of [Expense] rows into an [AnnualSummary], applying
/// deduction caps from [DeductionCaps].
class AnnualSummaryService {
  const AnnualSummaryService();

  /// Computes the summary in a background isolate (use for large datasets).
  Future<AnnualSummary> computeAsync(
    List<Expense> expenses,
    int fiscalYear, {
    int dependentCount = 0,
  }) =>
      compute(_computeInIsolate, (expenses, fiscalYear, dependentCount));

  /// Synchronous computation — fine for small datasets (e.g. single month).
  AnnualSummary computeSync(
    List<Expense> expenses,
    int fiscalYear, {
    int dependentCount = 0,
  }) {
    final caps = Map<DeductionCategory, int?>.of(DeductionCaps.forYear(fiscalYear));

    // Multiply education cap by (1 + dependentCount) — each person gets their own cap.
    if (dependentCount > 0) {
      final baseCap = caps[DeductionCategory.educacao];
      if (baseCap != null) {
        caps[DeductionCategory.educacao] = baseCap * (1 + dependentCount);
      }
    }

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

    // Add fixed dependent deduction.
    final perDependent = DeductionCaps.dependentDeductionFor(fiscalYear);
    final dependentDeduction = dependentCount * perDependent;
    totalDeductibleInCents += dependentDeduction;

    // Sort summaries by category label for a consistent display order.
    summaries.sort((a, b) => a.category.label.compareTo(b.category.label));

    return AnnualSummary(
      fiscalYear: fiscalYear,
      categories: summaries,
      totalInCents: totalInCents,
      totalDeductibleInCents: totalDeductibleInCents,
      dependentCount: dependentCount,
      dependentDeductionInCents: dependentDeduction,
    );
  }

  DeductionCategory _parseCategory(String raw) {
    return DeductionCategory.values.firstWhere(
      (c) => c.name == raw,
      orElse: () => DeductionCategory.saude,
    );
  }
}
