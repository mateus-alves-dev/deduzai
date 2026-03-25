import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/search_filter.dart';
import 'package:deduzai/core/theme/category_utils.dart';
import 'package:deduzai/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FilterPanel extends ConsumerStatefulWidget {
  const FilterPanel({super.key});

  @override
  ConsumerState<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends ConsumerState<FilterPanel> {
  final _amountFromCtrl = TextEditingController();
  final _amountToCtrl = TextEditingController();

  static final _dateFmt = DateFormat('dd/MM/yyyy', 'pt_BR');

  @override
  void dispose() {
    _amountFromCtrl.dispose();
    _amountToCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Categoria ───────────────────────────────────────────────────────
        ExpansionTile(
          title: const Text('Categoria'),
          leading: const Icon(Icons.category_outlined),
          initiallyExpanded: filter.categories.isNotEmpty,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: DeductionCategory.values.map((cat) {
                  final selected = filter.categories.contains(cat);
                  return FilterChip(
                    label: Text(cat.label),
                    selected: selected,
                    selectedColor:
                        colorForCategory(cat).withValues(alpha: 0.2),
                    checkmarkColor: colorForCategory(cat),
                    labelStyle: TextStyle(
                      color: selected ? colorForCategory(cat) : null,
                    ),
                    onSelected: (val) {
                      final cats = [...filter.categories];
                      if (val) {
                        cats.add(cat);
                      } else {
                        cats.remove(cat);
                      }
                      notifier.setCategories(cats);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),

        // ── Data ────────────────────────────────────────────────────────────
        ExpansionTile(
          title: const Text('Data'),
          leading: const Icon(Icons.date_range_outlined),
          initiallyExpanded:
              filter.dateFrom != null || filter.dateTo != null,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: _DatePickerField(
                      label: 'De',
                      value: filter.dateFrom,
                      lastDate: filter.dateTo ?? DateTime.now(),
                      onPicked: notifier.setDateFrom,
                      dateFmt: _dateFmt,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DatePickerField(
                      label: 'Até',
                      value: filter.dateTo,
                      firstDate: filter.dateFrom,
                      lastDate: DateTime.now(),
                      onPicked: notifier.setDateTo,
                      dateFmt: _dateFmt,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // ── Valor ────────────────────────────────────────────────────────────
        ExpansionTile(
          title: const Text('Valor'),
          leading: const Icon(Icons.attach_money_outlined),
          initiallyExpanded: filter.amountMinCents != null ||
              filter.amountMaxCents != null,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountFromCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'De (R\$)',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (v) {
                        final parsed = double.tryParse(
                          v.replaceAll(',', '.'),
                        );
                        notifier.setAmountRange(
                          parsed != null
                              ? (parsed * 100).round()
                              : null,
                          filter.amountMaxCents,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _amountToCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Até (R\$)',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onChanged: (v) {
                        final parsed = double.tryParse(
                          v.replaceAll(',', '.'),
                        );
                        notifier.setAmountRange(
                          filter.amountMinCents,
                          parsed != null
                              ? (parsed * 100).round()
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // ── Comprovante ──────────────────────────────────────────────────────
        ExpansionTile(
          title: const Text('Comprovante'),
          leading: const Icon(Icons.receipt_outlined),
          initiallyExpanded:
              filter.receiptFilter != SearchReceiptFilter.all,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SegmentedButton<SearchReceiptFilter>(
                segments: const [
                  ButtonSegment(
                    value: SearchReceiptFilter.all,
                    label: Text('Todos'),
                  ),
                  ButtonSegment(
                    value: SearchReceiptFilter.withReceipt,
                    label: Text('Com nota'),
                    icon: Icon(Icons.check_circle_outline, size: 16),
                  ),
                  ButtonSegment(
                    value: SearchReceiptFilter.withoutReceipt,
                    label: Text('Sem nota'),
                    icon: Icon(Icons.cancel_outlined, size: 16),
                  ),
                ],
                selected: {filter.receiptFilter},
                onSelectionChanged: (s) =>
                    notifier.setReceiptFilter(s.first),
              ),
            ),
          ],
        ),

        // ── Limpar tudo ──────────────────────────────────────────────────────
        if (filter.hasActiveFilters)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                notifier.clearAll();
                _amountFromCtrl.clear();
                _amountToCtrl.clear();
              },
              icon: const Icon(Icons.clear_all),
              label: const Text('Limpar filtros'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error),
              ),
            ),
          ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onPicked,
    required this.dateFmt,
    this.firstDate,
    this.lastDate,
  });

  final String label;
  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?) onPicked;
  final DateFormat dateFmt;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100),
          locale: const Locale('pt', 'BR'),
        );
        if (picked != null) onPicked(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          suffixIcon: value != null
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () => onPicked(null),
                )
              : const Icon(Icons.calendar_today_outlined, size: 16),
        ),
        child: Text(
          value != null ? dateFmt.format(value!) : '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
