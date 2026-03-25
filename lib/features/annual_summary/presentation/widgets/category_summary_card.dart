import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategorySummaryCard extends StatelessWidget {
  const CategorySummaryCard({required this.summary, super.key});

  final CategorySummary summary;

  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasCap = summary.capInCents != null;
    final capExceeded = summary.surplusInCents != null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _iconFor(summary.category),
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    summary.category.label,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  '${summary.count} gasto${summary.count != 1 ? 's' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _AmountRow(
              label: 'Total registrado',
              amountInCents: summary.totalInCents,
              currency: _currency,
            ),
            if (hasCap) ...[
              const SizedBox(height: 4),
              _AmountRow(
                label: 'Dedutível',
                amountInCents: summary.deductibleInCents,
                currency: _currency,
                bold: true,
                color: capExceeded ? theme.colorScheme.primary : null,
              ),
            ],
            if (capExceeded) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Teto atingido — excedente de '
                  '${_currency.format(summary.surplusInCents! / 100)}'
                  ' não dedutível',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ],
            if (!hasCap) ...[
              const SizedBox(height: 4),
              _AmountRow(
                label: 'Dedutível',
                amountInCents: summary.deductibleInCents,
                currency: _currency,
                bold: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _iconFor(DeductionCategory category) {
    return switch (category) {
      DeductionCategory.saude => Icons.health_and_safety_outlined,
      DeductionCategory.educacao => Icons.school_outlined,
      DeductionCategory.pensaoAlimenticia => Icons.family_restroom_outlined,
      DeductionCategory.previdenciaPrivada => Icons.savings_outlined,
      DeductionCategory.dependentes => Icons.people_outline,
      DeductionCategory.previdenciaSocial => Icons.account_balance_outlined,
      DeductionCategory.doacoesIncentivadas =>
        Icons.volunteer_activism_outlined,
      DeductionCategory.livroCaixa => Icons.menu_book_outlined,
    };
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.amountInCents,
    required this.currency,
    this.bold = false,
    this.color,
  });

  final String label;
  final int amountInCents;
  final NumberFormat currency;
  final bool bold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: bold ? FontWeight.bold : null,
      color: color,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(currency.format(amountInCents / 100), style: style),
      ],
    );
  }
}
