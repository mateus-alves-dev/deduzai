import 'dart:async';

import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/features/monthly_summary/domain/monthly_summary_service.dart';
import 'package:deduzai/features/monthly_summary/presentation/providers/monthly_summary_providers.dart';
import 'package:deduzai/features/monthly_summary/presentation/widgets/month_navigator.dart';
import 'package:deduzai/features/monthly_summary/presentation/widgets/monthly_breakdown_card.dart';
import 'package:deduzai/features/monthly_summary/presentation/widgets/pie_chart_widget.dart';
import 'package:deduzai/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MonthlySummaryScreen extends ConsumerWidget {
  const MonthlySummaryScreen({super.key});

  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(selectedMonthProvider);
    final summaryAsync = ref.watch(monthlySummaryProvider(period));

    return summaryAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erro: $e')),
      data: (summary) => _SummaryContent(
        summary: summary,
        period: period,
        currency: _currency,
      ),
    );
  }
}

class _SummaryContent extends ConsumerWidget {
  const _SummaryContent({
    required this.summary,
    required this.period,
    required this.currency,
  });

  final MonthlySummary summary;
  final MonthPeriod period;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // ── Month navigator ──────────────────────────────────────────────────
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: MonthNavigator(),
        ),

        // ── Hero total ───────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.format(summary.totalInCents / 100),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (summary.percentChangeVsPrev != null) ...[
                    const SizedBox(height: 4),
                    _ComparisonBadge(
                      percent: summary.percentChangeVsPrev!,
                      prevMonth: _prevMonthLabel(period),
                    ),
                  ] else if (summary.prevMonthTotalInCents == 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Sem dados no mês anterior',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        // ── Pie chart ────────────────────────────────────────────────────────
        if (summary.categories.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: PieChartWidget(categories: summary.categories),
          ),

        // ── Breakdown ────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Detalhes por categoria',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        if (summary.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                'Nenhum gasto registrado neste mês.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          )
        else
          for (final cat in summary.categories)
            MonthlyBreakdownCard(
              monthly: cat,
              ytd: summary.ytdCategories
                  .where((c) => c.category == cat.category)
                  .firstOrNull,
              onTap: () => _openSearch(context, ref, cat.category),
            ),
      ],
    );
  }

  void _openSearch(
    BuildContext context,
    WidgetRef ref,
    DeductionCategory category,
  ) {
    final notifier = ref.read(searchNotifierProvider.notifier);
    notifier.clearAll();
    notifier.setCategories([category]);
    notifier.setDateFrom(DateTime(period.year, period.month));
    notifier.setDateTo(
      DateTime(period.year, period.month + 1).subtract(const Duration(days: 1)),
    );
    unawaited(context.push('/search'));
  }

  String _prevMonthLabel(MonthPeriod period) {
    final prevMonth = period.month == 1 ? 12 : period.month - 1;
    final prevYear = period.month == 1 ? period.year - 1 : period.year;
    final date = DateTime(prevYear, prevMonth);
    final raw = DateFormat('MMM/yyyy', 'pt_BR').format(date);
    return raw[0].toUpperCase() + raw.substring(1);
  }
}

class _ComparisonBadge extends StatelessWidget {
  const _ComparisonBadge({required this.percent, required this.prevMonth});

  final double percent;
  final String prevMonth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUp = percent > 0;
    final color = isUp ? theme.colorScheme.error : Colors.green;
    final icon = isUp ? Icons.arrow_upward : Icons.arrow_downward;
    final sign = isUp ? '+' : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 2),
        Text(
          '$sign${percent.toStringAsFixed(1)}% em relação a $prevMonth',
          style: theme.textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
