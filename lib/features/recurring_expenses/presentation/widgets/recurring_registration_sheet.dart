import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:deduzai/features/recurring_expenses/domain/recurring_expense_service.dart';
import 'package:deduzai/features/recurring_expenses/presentation/providers/recurring_expense_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Represents one pending registration slot (one period for one template).
class _PendingItem {
  _PendingItem({
    required this.template,
    required this.dueDate,
  });

  final RecurringExpense template;
  final DateTime dueDate;
}

void showRecurringRegistrationSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _RecurringRegistrationSheet(),
  );
}

class _RecurringRegistrationSheet extends ConsumerStatefulWidget {
  const _RecurringRegistrationSheet();

  @override
  ConsumerState<_RecurringRegistrationSheet> createState() =>
      _RecurringRegistrationSheetState();
}

class _RecurringRegistrationSheetState
    extends ConsumerState<_RecurringRegistrationSheet> {
  List<_PendingItem>? _items;
  final Set<int> _selectedIndexes = {};
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _buildItems());
  }

  void _buildItems() {
    final dueList = ref.read(dueRecurringExpensesProvider).value ?? [];
    final items = <_PendingItem>[];
    final today = DateTime.now();

    for (final template in dueList) {
      // Generate all pending occurrences for this template
      var current = template.nextDueDate;
      final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);
      int safetyCount = 0;

      while (!current.isAfter(todayEnd) && safetyCount < 36) {
        items.add(_PendingItem(template: template, dueDate: current));
        current = RecurringExpenseService.computeNextDueDate(
          frequency: RecurrenceFrequency.fromValue(template.frequency),
          referenceDate: template.referenceDate,
          from: current,
          dayOfMonth: template.dayOfMonth,
        );
        safetyCount++;
      }
    }

    setState(() {
      _items = items;
      _selectedIndexes.addAll(List.generate(items.length, (i) => i));
    });
  }

  Future<void> _register() async {
    if (_items == null || _selectedIndexes.isEmpty) return;

    setState(() => _loading = true);

    try {
      final service = ref.read(recurringExpenseServiceProvider);
      int count = 0;

      // Group selected items by template and register in order
      final selected = _selectedIndexes.map((i) => _items![i]).toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

      // We need to re-fetch after each registration because nextDueDate advances.
      // Instead, we register by calling registerAllPending for selected templates.
      final selectedTemplateIds =
          selected.map((e) => e.template.id).toSet();

      for (final templateId in selectedTemplateIds) {
        final templateItems =
            selected.where((e) => e.template.id == templateId).toList();

        for (var i = 0; i < templateItems.length; i++) {
          // Fetch latest template state before each registration
          final RecurringExpense? latest = await ref
              .read(recurringExpenseDaoProvider)
              .getById(templateId);
          if (latest == null) break;
          await service.registerOccurrence(
              latest, forDate: latest.nextDueDate);
          count++;
        }
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              count == 1
                  ? '1 gasto registrado ✓'
                  : '$count gastos registrados ✓',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = _items;

    if (items == null) {
      return const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text('Nenhuma recorrência pendente',
                style: AppTextStyles.titleMedium),
          ],
        ),
      );
    }

    final totalCents = _selectedIndexes
        .map((i) => items[i].template.amountInCents)
        .fold(0, (a, b) => a + b);
    final totalFormatted = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: r'R$',
    ).format(totalCents / 100);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (_, controller) => Column(
        children: [
          // Handle
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Registrar recorrências',
                          style: AppTextStyles.titleLarge),
                      Text(
                        '${_selectedIndexes.length} item(s) · $totalFormatted',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
          // List
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i];
                final category =
                    DeductionCategory.values.byName(item.template.category);
                final color = colorForCategory(category);
                final amount = item.template.amountInCents / 100;
                final formatted = NumberFormat.currency(
                  locale: 'pt_BR',
                  symbol: r'R$',
                ).format(amount);
                final dateLabel =
                    DateFormat('MMM/yyyy', 'pt_BR').format(item.dueDate);

                return CheckboxListTile(
                  value: _selectedIndexes.contains(i),
                  onChanged: _loading
                      ? null
                      : (v) => setState(() {
                            if (v == true) {
                              _selectedIndexes.add(i);
                            } else {
                              _selectedIndexes.remove(i);
                            }
                          }),
                  secondary: Container(
                    width: 4,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  title: Text(
                    item.template.description.isNotEmpty
                        ? item.template.description
                        : category.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${category.label} · $dateLabel · $formatted',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer button
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md +
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _loading || _selectedIndexes.isEmpty
                    ? null
                    : _register,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Registrar selecionados'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
