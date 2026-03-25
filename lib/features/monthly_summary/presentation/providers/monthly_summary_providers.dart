import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/features/monthly_summary/domain/monthly_summary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MonthPeriod = ({int year, int month});

final selectedMonthProvider =
    NotifierProvider<SelectedMonthNotifier, MonthPeriod>(
  SelectedMonthNotifier.new,
);

class SelectedMonthNotifier extends Notifier<MonthPeriod> {
  @override
  MonthPeriod build() {
    final now = DateTime.now();
    return (year: now.year, month: now.month);
  }

  void select(MonthPeriod period) => state = period;
}

final monthlySummaryProvider =
    FutureProvider.autoDispose.family<MonthlySummary, MonthPeriod>(
  (ref, period) async {
    final dao = ref.watch(expenseDaoProvider);

    final monthExpenses = await dao.getByMonth(period.year, period.month);

    final (int prevYear, int prevMonth) = period.month == 1
        ? (period.year - 1, 12)
        : (period.year, period.month - 1);
    final prevExpenses = await dao.getByMonth(prevYear, prevMonth);

    final ytdExpenses =
        await dao.getByYearUpToMonth(period.year, period.month);

    return ref.read(monthlySummaryServiceProvider).computeMonthly(
          monthExpenses: monthExpenses,
          prevMonthExpenses: prevExpenses,
          yearToDateExpenses: ytdExpenses,
          year: period.year,
          month: period.month,
        );
  },
);
