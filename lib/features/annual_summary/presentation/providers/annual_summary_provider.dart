import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/features/annual_summary/domain/annual_summary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annual_summary_provider.g.dart';

/// Currently selected fiscal year. Defaults to the current calendar year.
@riverpod
class SelectedYear extends _$SelectedYear {
  @override
  int build() => DateTime.now().year;

  // ignore: use_setters_to_change_properties -- Riverpod Notifier pattern
  void select(int year) => state = year;

}

/// Reactive stream of [AnnualSummary] for [year].
///
/// Recomputes whenever the underlying expenses change (Drift stream).
@riverpod
Stream<AnnualSummary> annualSummary(Ref ref, int year) {
  final service = ref.watch(annualSummaryServiceProvider);
  return ref
      .watch(expenseDaoProvider)
      .watchByYear(year)
      .map((List<Expense> expenses) => service.compute(expenses, year));
}

/// Raw expenses for [year] — used by the export service to build exports.
@riverpod
Future<List<Expense>> expensesForYear(Ref ref, int year) =>
    ref.watch(expenseDaoProvider).watchByYear(year).first;
