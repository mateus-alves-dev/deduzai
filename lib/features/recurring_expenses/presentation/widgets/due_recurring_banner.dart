import 'package:deduzai/features/recurring_expenses/presentation/providers/recurring_expense_providers.dart';
import 'package:deduzai/features/recurring_expenses/presentation/widgets/recurring_registration_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DueRecurringBanner extends ConsumerWidget {
  const DueRecurringBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueAsync = ref.watch(dueRecurringExpensesProvider);

    return dueAsync.maybeWhen(
      data: (dueList) {
        if (dueList.isEmpty) return const SizedBox.shrink();

        final count = dueList.length;
        final label = count == 1 ? '1 recorrência vencida' : '$count recorrências vencidas';

        return MaterialBanner(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          leading: const Icon(Icons.repeat, size: 20),
          content: Text(label),
          actions: [
            TextButton(
              onPressed: () => showRecurringRegistrationSheet(context),
              child: const Text('Registrar'),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
