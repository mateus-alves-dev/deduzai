import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
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
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatted,
            style: AppTextStyles.amountDisplay.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 2),
          _ReceiptIcon(expenseId: expense.id),
        ],
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
    DeductionCategory.previdenciaSocial => AppColors.categoryPrevidenciaSocial,
    DeductionCategory.doacoesIncentivadas => AppColors.categoryDoacoes,
    DeductionCategory.livroCaixa => AppColors.categoryLivroCaixa,
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

class _ReceiptIcon extends ConsumerWidget {
  const _ReceiptIcon({required this.expenseId});

  final String expenseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasReceipt =
        ref.watch(expenseHasReceiptProvider(expenseId)).value ?? false;

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
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.receipt_outlined,
          size: 16,
          color: hasReceipt
              ? AppColors.success
              : Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
