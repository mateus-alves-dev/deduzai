import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptMetadataPanel extends StatelessWidget {
  const ReceiptMetadataPanel({required this.expense, super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final category = DeductionCategory.values.byName(expense.category);
    final amount = expense.amountInCents / 100;
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(amount);
    final date = DateFormat('dd/MM/yyyy').format(expense.date);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            expense.description.isNotEmpty
                ? expense.description
                : category.label,
            style: AppTextStyles.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Text(category.label, style: AppTextStyles.bodyMedium),
              const Spacer(),
              Text(
                formatted,
                style: AppTextStyles.amountDisplay.copyWith(fontSize: 16),
              ),
            ],
          ),
          if (expense.beneficiario?.isNotEmpty ?? false)
            Text(expense.beneficiario!, style: AppTextStyles.bodyMedium),
          Text(date, style: AppTextStyles.labelMedium),
        ],
      ),
    );
  }
}
