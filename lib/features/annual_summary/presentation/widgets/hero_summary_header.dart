import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeroSummaryHeader extends StatelessWidget {
  const HeroSummaryHeader({
    required this.summary,
    required this.currency,
    super.key,
  });

  final AnnualSummary summary;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalExpenses =
        summary.categories.fold(0, (sum, c) => sum + c.count);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total registrado',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withAlpha(178),
              ),
            ),
            Text(
              currency.format(summary.totalInCents / 100),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Total dedutível',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            Text(
              currency.format(summary.totalDeductibleInCents / 100),
              style: AppTextStyles.amountDisplay.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 16,
                  color: theme.colorScheme.onPrimaryContainer.withAlpha(178),
                ),
                const SizedBox(width: 4),
                Text(
                  '$totalExpenses '
                  'gasto${totalExpenses != 1 ? 's' : ''} '
                  'registrado${totalExpenses != 1 ? 's' : ''}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color:
                        theme.colorScheme.onPrimaryContainer.withAlpha(178),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
