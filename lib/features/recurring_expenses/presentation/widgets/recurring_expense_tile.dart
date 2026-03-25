import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecurringExpenseTile extends StatelessWidget {
  const RecurringExpenseTile({
    required this.template,
    required this.onTap,
    super.key,
  });

  final RecurringExpense template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final category = DeductionCategory.values.byName(template.category);
    final color = colorForCategory(category);
    final amount = template.amountInCents / 100;
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(amount);
    final frequency = RecurrenceFrequency.fromValue(template.frequency);
    final nextDate = DateFormat('dd/MM/yyyy').format(template.nextDueDate);
    final theme = Theme.of(context);
    final isDue = !template.nextDueDate.isAfter(DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 4, color: template.isActive ? color : theme.colorScheme.outlineVariant),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              template.description.isNotEmpty
                                  ? template.description
                                  : category.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleMedium,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                // Category pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    category.label,
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: color,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                // Frequency pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    frequency.label,
                                    style: AppTextStyles.labelMedium.copyWith(
                                      color: theme.colorScheme.onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                Icon(
                                  isDue
                                      ? Icons.warning_amber_outlined
                                      : Icons.event_outlined,
                                  size: 13,
                                  color: isDue
                                      ? theme.colorScheme.error
                                      : theme.colorScheme.outline,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  isDue
                                      ? 'Vencida em $nextDate'
                                      : 'Próxima: $nextDate',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: isDue
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatted,
                            style: AppTextStyles.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          if (!template.isActive)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Pausada',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
