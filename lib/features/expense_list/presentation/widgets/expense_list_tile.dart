import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:deduzai/features/expense_list/presentation/providers/expense_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseListTile extends ConsumerWidget {
  const ExpenseListTile({
    required this.expense,
    required this.onTap,
    super.key,
  });

  final Expense expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = DeductionCategory.values.byName(expense.category);
    final categoryColor = colorForCategory(category);
    final amount = expense.amountInCents / 100;
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(amount);
    final date = DateFormat('dd/MM/yyyy').format(expense.date);
    final hasBeneficiario = expense.beneficiario?.isNotEmpty ?? false;
    final theme = Theme.of(context);

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
              Container(width: 4, color: categoryColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Left: text info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense.description.isNotEmpty
                                  ? expense.description
                                  : category.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleMedium,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            // Category pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                category.label,
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: categoryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            if (hasBeneficiario) ...[
                              Text(
                                expense.beneficiario!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                            Text(
                              date,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      // Right: amount + receipt badge
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatted,
                            style: AppTextStyles.titleLarge.copyWith(
                              fontFeatures: [
                                const FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          _ReceiptBadge(expenseId: expense.id),
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

class _ReceiptBadge extends ConsumerWidget {
  const _ReceiptBadge({required this.expenseId});

  final String expenseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReceipt =
        ref.watch(expenseHasReceiptProvider(expenseId)).value ?? false;
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (hasReceipt) {
          context.push('/expenses/$expenseId/receipt');
        } else {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) => SafeArea(
              child: ListTile(
                leading: const Icon(Icons.add_a_photo_outlined),
                title: const Text('Adicionar comprovante agora'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.push('/expenses/$expenseId/receipt');
                },
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: hasReceipt
              ? Colors.green.withValues(alpha: 0.12)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasReceipt ? Icons.check_circle : Icons.add_a_photo_outlined,
              size: 14,
              color: hasReceipt
                  ? Colors.green
                  : theme.colorScheme.outline,
            ),
            const SizedBox(width: 3),
            Text(
              hasReceipt ? 'Nota' : 'Sem nota',
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 11,
                color: hasReceipt
                    ? Colors.green
                    : theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
