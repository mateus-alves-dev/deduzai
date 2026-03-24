import 'package:deduzai/features/expense_list/presentation/providers/expense_list_provider.dart';
import 'package:deduzai/features/expense_list/presentation/widgets/expense_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseAsync = ref.watch(expenseListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gastos')),
      body: expenseAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro ao carregar gastos: $e')),
        data: (expenses) {
          if (expenses.isEmpty) {
            return const _EmptyState();
          }
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, i) {
              final expense = expenses[i];
              return ExpenseListTile(
                expense: expense,
                onTap: () => context.push('/expenses/${expense.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/expenses/new'),
        icon: const Icon(Icons.add),
        label: const Text('Novo gasto'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum gasto registrado',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Toque em "Novo gasto" para começar',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
