import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';

/// Summary of deductible expenses for a single [DeductionCategory].
class CategorySummary {
  const CategorySummary({
    required this.category,
    required this.totalInCents,
    required this.deductibleInCents,
    required this.count,
    required this.expenses,
    this.capInCents,
    this.surplusInCents,
  });

  final DeductionCategory category;

  /// Raw total of all expenses in this category (centavos).
  final int totalInCents;

  /// Deductible amount after applying the cap (centavos).
  final int deductibleInCents;

  /// Deduction ceiling for this category/year. Null means unlimited.
  final int? capInCents;

  /// Amount that exceeds the cap (centavos). Null when cap not exceeded.
  final int? surplusInCents;

  /// Number of expenses in this category.
  final int count;

  /// Individual expenses (ordered by date desc).
  final List<Expense> expenses;
}

/// Aggregated annual tax-deduction summary for a given [fiscalYear].
class AnnualSummary {
  const AnnualSummary({
    required this.fiscalYear,
    required this.categories,
    required this.totalInCents,
    required this.totalDeductibleInCents,
    this.dependentCount = 0,
    this.dependentDeductionInCents = 0,
  });

  final int fiscalYear;

  /// One entry per category that has at least one expense.
  final List<CategorySummary> categories;

  /// Sum of all expense amounts (centavos), regardless of caps.
  final int totalInCents;

  /// Sum of deductible amounts after applying caps (centavos),
  /// including the fixed dependent deduction.
  final int totalDeductibleInCents;

  /// Number of active dependents contributing to the deduction.
  final int dependentCount;

  /// Total fixed deduction from dependents (centavos):
  /// [dependentCount] × per-dependent deduction for [fiscalYear].
  final int dependentDeductionInCents;

  bool get isEmpty => categories.isEmpty && dependentCount == 0;
}
