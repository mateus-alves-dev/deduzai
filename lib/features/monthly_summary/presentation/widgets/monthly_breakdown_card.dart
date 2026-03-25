import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyBreakdownCard extends StatelessWidget {
  const MonthlyBreakdownCard({
    required this.monthly,
    required this.ytd,
    required this.onTap,
    super.key,
  });

  final CategorySummary monthly;
  final CategorySummary? ytd;
  final VoidCallback onTap;

  static final _currency =
      NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = colorForCategory(monthly.category);
    final icon = iconForCategory(monthly.category);

    final ytdTotal = ytd?.totalInCents ?? monthly.totalInCents;
    final cap = monthly.capInCents;
    final ytdFraction = cap != null ? (ytdTotal / cap).clamp(0.0, 1.0) : null;

    final Color progressColor;
    if (ytdFraction == null) {
      progressColor = color;
    } else if (ytdFraction >= 1.0) {
      progressColor = theme.colorScheme.error;
    } else if (ytdFraction >= 0.8) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      monthly.category.label,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    _currency.format(monthly.totalInCents / 100),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (cap != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ytdFraction,
                    backgroundColor:
                        progressColor.withValues(alpha: 0.12),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(progressColor),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Acumulado: ${_currency.format(ytdTotal / 100)}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Teto: ${_currency.format(cap / 100)}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
