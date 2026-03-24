import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({
    required this.expense,
    required this.onTap,
    super.key,
  });

  final Expense expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final category = DeductionCategory.values.byName(expense.category);
    final amount = expense.amountInCents / 100;
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(amount);
    final date = DateFormat('dd/MM/yyyy').format(expense.date);
    final hasBeneficiario = expense.beneficiario?.isNotEmpty ?? false;
    final subtitle = hasBeneficiario ? expense.beneficiario! : date;

    return ListTile(
      onTap: onTap,
      leading: _CategoryDot(category: category),
      title: Text(
        expense.description.isNotEmpty ? expense.description : category.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.titleMedium,
      ),
      subtitle: Text(
        '$subtitle · $date',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodyMedium,
      ),
      trailing: Text(
        formatted,
        style: AppTextStyles.amountDisplay.copyWith(fontSize: 15),
      ),
    );
  }
}

class _CategoryDot extends StatelessWidget {
  const _CategoryDot({required this.category});

  final DeductionCategory category;

  static Color _colorFor(DeductionCategory c) => switch (c) {
    DeductionCategory.saude => AppColors.categorySaude,
    DeductionCategory.educacao => AppColors.categoryEducacao,
    DeductionCategory.pensaoAlimenticia => AppColors.categoryPensao,
    DeductionCategory.previdenciaPrivada => AppColors.categoryPrevidencia,
    DeductionCategory.dependentes => AppColors.categoryDependentes,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _colorFor(category),
        shape: BoxShape.circle,
      ),
    );
  }
}
