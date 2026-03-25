import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/features/annual_summary/domain/annual_summary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Currently selected fiscal year. Defaults to the current calendar year.
final selectedYearProvider =
    NotifierProvider<SelectedYear, int>(SelectedYear.new);

class SelectedYear extends Notifier<int> {
  @override
  int build() => DateTime.now().year;

  // ignore: use_setters_to_change_properties -- Riverpod Notifier pattern
  void select(int year) => state = year;
}

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses change (Drift stream).
final annualSummaryProvider =
    StreamProvider.family<AnnualSummary, int>((ref, year) {
  final service = ref.watch(annualSummaryServiceProvider);
  return ref
      .watch(expenseDaoProvider)
      .watchByYear(year)
      .map((List<Expense> expenses) => service.compute(expenses, year));
});

/// Raw expenses for [year] — used by the export service to build exports.
final expensesForYearProvider =
    FutureProvider.family<List<Expense>, int>((ref, year) =>
        ref.watch(expenseDaoProvider).watchByYear(year).first);
