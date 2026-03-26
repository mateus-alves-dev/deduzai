import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/deduction_caps.dart';
import 'package:deduzai/core/domain/models/relationship.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/dependents/presentation/providers/dependent_providers.dart';
import 'package:deduzai/features/dependents/presentation/widgets/dependent_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DependentsSection extends ConsumerWidget {
  const DependentsSection({required this.fiscalYear, super.key});

  final int fiscalYear;

  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final listAsync = ref.watch(dependentListProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(width: 4, color: AppColors.categoryDependentes),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, theme),
                    const SizedBox(height: AppSpacing.sm),
                    listAsync.when(
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: LinearProgressIndicator(),
                      ),
                      error: (e, _) => Text(
                        'Erro ao carregar dependentes: $e',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                      data: (dependents) =>
                          _buildContent(context, theme, dependents),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        const Icon(
          Icons.people_outline,
          color: AppColors.categoryDependentes,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            'Dependentes',
            style: theme.textTheme.titleMedium,
          ),
        ),
        TextButton.icon(
          onPressed: () => DependentFormSheet.show(context),
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Adicionar'),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme,
    List<Dependent> dependents,
  ) {
    if (dependents.isEmpty) {
      final deduction = _currency.format(
        DeductionCaps.dependentDeductionFor(fiscalYear) / 100,
      );
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(
          'Nenhum dependente cadastrado. Cada dependente '
          'reduz a base de cálculo em $deduction'
          ' por ano.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      );
    }

    final perDependent = DeductionCaps.dependentDeductionFor(fiscalYear);
    final totalDeduction = dependents.length * perDependent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...dependents.map(
          (d) => _DependentTile(
            dependent: d,
            onEdit: () => DependentFormSheet.show(context, dependent: d),
          ),
        ),
        const Divider(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${dependents.length} '
              'dependente${dependents.length != 1 ? 's' : ''} × '
              '${_currency.format(perDependent / 100)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            Text(
              _currency.format(totalDeduction / 100),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DependentTile extends StatelessWidget {
  const _DependentTile({
    required this.dependent,
    required this.onEdit,
  });

  final Dependent dependent;
  final VoidCallback onEdit;

  static final _dateFmt = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final relationship = Relationship.fromValue(dependent.relationship);

    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.categoryDependentes.withAlpha(30),
              child: Text(
                dependent.name.isNotEmpty
                    ? dependent.name[0].toUpperCase()
                    : '?',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.categoryDependentes,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dependent.name,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    '${relationship.label} · '
                    '${_dateFmt.format(dependent.birthDate)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: theme.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
