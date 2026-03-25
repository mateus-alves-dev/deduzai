import 'package:deduzai/features/monthly_summary/presentation/providers/monthly_summary_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MonthNavigator extends ConsumerWidget {
  const MonthNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(selectedMonthProvider);
    final label = _monthLabel(period.year, period.month);
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _navigate(ref, period, -1),
        ),
        GestureDetector(
          onTap: () => _showMonthPicker(context, ref, period),
          child: Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed:
              _isCurrentMonth(period) ? null : () => _navigate(ref, period, 1),
        ),
      ],
    );
  }

  void _navigate(WidgetRef ref, MonthPeriod period, int delta) {
    var month = period.month + delta;
    var year = period.year;
    if (month < 1) {
      month = 12;
      year -= 1;
    } else if (month > 12) {
      month = 1;
      year += 1;
    }
    ref.read(selectedMonthProvider.notifier).select((year: year, month: month));
  }

  bool _isCurrentMonth(MonthPeriod period) {
    final now = DateTime.now();
    return period.year == now.year && period.month == now.month;
  }

  String _monthLabel(int year, int month) {
    final date = DateTime(year, month);
    final raw = DateFormat('MMMM yyyy', 'pt_BR').format(date);
    return raw[0].toUpperCase() + raw.substring(1);
  }

  Future<void> _showMonthPicker(
    BuildContext context,
    WidgetRef ref,
    MonthPeriod current,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(current.year, current.month),
      firstDate: DateTime(2020),
      lastDate: now,
      locale: const Locale('pt', 'BR'),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      ref.read(selectedMonthProvider.notifier).select(
            (year: picked.year, month: picked.month),
          );
    }
  }
}
