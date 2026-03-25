import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:deduzai/features/expense_list/presentation/providers/expense_list_provider.dart';
import 'package:deduzai/features/expense_list/presentation/widgets/expense_list_tile.dart';
import 'package:deduzai/features/notifications/presentation/widgets/notification_permission_banner.dart';
import 'package:deduzai/features/recurring_expenses/presentation/widgets/due_recurring_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAsync = ref.watch(expenseListProvider);

    return Scaffold(
      appBar: DeduzaiAppBar(
        title: 'Gastos',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Buscar',
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: expenseAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro ao carregar gastos: $e')),
        data: (expenses) {
          if (expenses.isEmpty) {
            return const _EmptyState();
          }
          return _GroupedExpenseList(expenses: expenses);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => context.push('/expenses/new'),
      //   icon: const Icon(Icons.add),
      //   label: const Text('Novo gasto'),
      // ),
    );
  }
}

class _GroupedExpenseList extends StatelessWidget {
  const _GroupedExpenseList({required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // Group by month (expenses are already sorted by date desc)
    final groups = <String, List<Expense>>{};
    for (final expense in expenses) {
      final key = DateFormat('yyyy-MM').format(expense.date);
      groups.putIfAbsent(key, () => []).add(expense);
    }
    final monthKeys = groups.keys.toList();

    final totalCents = expenses.fold<int>(0, (s, e) => s + e.amountInCents);
    final year = DateTime.now().year;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _YearSummaryHeader(
            year: year,
            totalCents: totalCents,
            count: expenses.length,
          ),
        ),
        const SliverToBoxAdapter(child: DueRecurringBanner()),
        const SliverToBoxAdapter(child: NotificationPermissionBanner()),
        for (final monthKey in monthKeys) ...[
          SliverToBoxAdapter(
            child: _MonthSectionHeader(
              monthKey: monthKey,
              expenses: groups[monthKey]!,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final expense = groups[monthKey]![i];
                return ExpenseListTile(
                  expense: expense,
                  onTap: () => context.push('/expenses/${expense.id}'),
                );
              },
              childCount: groups[monthKey]!.length,
            ),
          ),
        ],
        // Bottom padding so FAB doesn't cover last item
        const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
      ],
    );
  }
}

class _YearSummaryHeader extends StatelessWidget {
  const _YearSummaryHeader({
    required this.year,
    required this.totalCents,
    required this.count,
  });

  final int year;
  final int totalCents;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(totalCents / 100);

    return Card(
      margin: const EdgeInsets.all(AppSpacing.md),
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total dedutível $year',
              style: AppTextStyles.labelMedium.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              formatted,
              style: AppTextStyles.amountDisplay.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$count gasto${count != 1 ? 's' : ''} registrado${count != 1 ? 's' : ''}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthSectionHeader extends StatelessWidget {
  const _MonthSectionHeader({
    required this.monthKey,
    required this.expenses,
  });

  final String monthKey;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateFormat('yyyy-MM').parse(monthKey);
    final monthName = DateFormat('MMMM yyyy', 'pt_BR').format(date);
    final capitalizedMonth =
        monthName[0].toUpperCase() + monthName.substring(1);
    final subtotal = expenses.fold<int>(0, (s, e) => s + e.amountInCents);
    final formatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(subtotal / 100);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Text(
            capitalizedMonth,
            style: AppTextStyles.titleMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          Text(
            formatted,
            style: AppTextStyles.labelMedium.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.receipt_long_outlined,
                size: 48,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Nenhum gasto registrado',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Registre seus gastos dedutíveis e acompanhe suas economias no Imposto de Renda.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.tonal(
              onPressed: () => context.push('/expenses/new'),
              child: const Text('Registrar primeiro gasto'),
            ),
          ],
        ),
      ),
    );
  }
}
