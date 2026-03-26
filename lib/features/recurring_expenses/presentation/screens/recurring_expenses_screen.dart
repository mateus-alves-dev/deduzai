import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:deduzai/features/recurring_expenses/domain/recurring_expense_service.dart';
import 'package:deduzai/features/recurring_expenses/presentation/providers/recurring_expense_providers.dart';
import 'package:deduzai/features/recurring_expenses/presentation/widgets/recurring_expense_tile.dart';
import 'package:deduzai/features/recurring_expenses/presentation/widgets/recurring_registration_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecurringExpensesScreen extends ConsumerWidget {
  const RecurringExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(recurringExpenseListProvider);
    final dueCount = ref.watch(dueRecurringExpensesCountProvider);

    return Scaffold(
      appBar: DeduzaiAppBar(
        title: 'Recorrências',
        actions: [
          if (dueCount > 0)
            FilledButton.tonal(
              onPressed: () => showRecurringRegistrationSheet(context),
              child: Text('Registrar ($dueCount)'),
            ),
        ],
      ),
      body: listAsync.when(
        data: (templates) {
          if (templates.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.repeat, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhuma recorrência cadastrada',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toque em + para adicionar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: templates.length,
            itemBuilder: (_, i) {
              final template = templates[i];
              return Dismissible(
                key: ValueKey(template.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                confirmDismiss: (_) => _confirmDelete(context),
                onDismissed: (_) {
                  ref
                      .read(recurringExpenseServiceProvider)
                      .deleteTemplate(template.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recorrência removida')),
                  );
                },
                child: RecurringExpenseTile(
                  template: template,
                  onTap: () => context.push('/recurring/${template.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover recorrência?'),
        content: const Text(
          'Os gastos já registrados não serão afetados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }
}
