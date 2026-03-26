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

/// Reactive count of active dependents. Rebuilds when dependents change.
final dependentCountProvider = StreamProvider<int>(
  (ref) => ref.watch(dependentsDaoProvider).watchActiveCount(),
);

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses or dependent count change.
/// Heavy computation runs in a background isolate via [AnnualSummaryService].
final annualSummaryProvider =
    StreamProvider.family<AnnualSummary, int>((ref, year) {
  final service = ref.watch(annualSummaryServiceProvider);
  final depCount = ref.watch(dependentCountProvider).value ?? 0;

  return ref
      .watch(expenseDaoProvider)
      .watchByYear(year)
      .asyncMap(
        (List<Expense> expenses) =>
            service.computeAsync(expenses, year, dependentCount: depCount),
      );
});

/// Raw expenses for [year] — used by the export service to build exports.
final expensesForYearProvider =
    FutureProvider.family<List<Expense>, int>((ref, year) =>
        ref.watch(expenseDaoProvider).watchByYear(year).first);
