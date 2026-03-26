import 'dart:async';

import 'package:deduzai/core/domain/models/refund_simulation.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/annual_summary/domain/refund_simulation_service.dart';
import 'package:deduzai/features/annual_summary/presentation/providers/gross_income_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RefundSimulationCard extends ConsumerStatefulWidget {
  const RefundSimulationCard({
    required this.totalDeductibleInCents,
    required this.fiscalYear,
    super.key,
  });

  final int totalDeductibleInCents;
  final int fiscalYear;

  @override
  ConsumerState<RefundSimulationCard> createState() =>
      _RefundSimulationCardState();
}

class _RefundSimulationCardState extends ConsumerState<RefundSimulationCard> {
  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  final _controller = TextEditingController();
  Timer? _debounce;
  int? _incomeInCents;
  bool _isUpdatingText = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  // --- currency helpers ---

  /// Formats centavos as "1.234,56" (no symbol — the prefix is in the field).
  String _formatCentsForField(int cents) {
    final value = cents / 100;
    final f = NumberFormat('#,##0.00', 'pt_BR');
    return f.format(value);
  }

  /// Parses a user-typed string into centavos.
  int? _parseToCents(String text) {
    final digits = text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    return int.tryParse(digits);
  }

  // --- input handling ---

  void _onIncomeChanged(String raw) {
    // Re-format the field in-place so the user sees "1.234,56".
    final cents = _parseToCents(raw);
    _applyFormattedText(cents);

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await _persistAndRecalculate(cents);
    });
  }

  void _applyFormattedText(int? cents) {
    _isUpdatingText = true;
    if (cents == null || cents == 0) {
      _controller.value = TextEditingValue.empty;
      _isUpdatingText = false;
      setState(() => _incomeInCents = null);
      return;
    }
    final formatted = _formatCentsForField(cents);
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    _isUpdatingText = false;
    setState(() => _incomeInCents = cents);
  }

  Future<void> _persistAndRecalculate(int? cents) async {
    await ref
        .read(grossIncomeUpdaterProvider(widget.fiscalYear))
        .update(cents);
  }

  // --- simulation ---

  RefundSimulation? _simulate() {
    final income = _incomeInCents;
    if (income == null || income == 0) return null;
    return ref.read(refundSimulationServiceProvider).simulate(
          grossIncomeInCents: income,
          totalDeductibleInCents: widget.totalDeductibleInCents,
          fiscalYear: widget.fiscalYear,
        );
  }

  // --- build ---

  @override
  Widget build(BuildContext context) {
    // Load saved income on first build / when year changes.
    ref.watch(grossAnnualIncomeProvider(widget.fiscalYear)).whenData((value) {
      if (!_isUpdatingText &&
          _incomeInCents == null &&
          value != null &&
          _controller.text.isEmpty) {
        // Seed the field once from the persisted value.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _applyFormattedText(value);
        });
      }
    });

    final theme = Theme.of(context);
    final simulation = _simulate();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            const SizedBox(height: AppSpacing.md),
            _buildIncomeField(theme),
            if (simulation != null) ...[
              const SizedBox(height: AppSpacing.lg),
              _buildRefundHighlight(theme, simulation),
              const SizedBox(height: AppSpacing.sm),
              _buildBreakdown(theme, simulation),
            ] else if (_incomeInCents == null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                'Informe sua renda bruta anual para simular a restituição',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.calculate_outlined,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'Simulador de Restituição',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeField(ThemeData theme) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
      ],
      decoration: InputDecoration(
        labelText: 'Renda bruta anual',
        prefixText: r'R$ ',
        border: const OutlineInputBorder(),
        prefixStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
      onChanged: (value) {
        if (!_isUpdatingText) _onIncomeChanged(value);
      },
    );
  }

  Widget _buildRefundHighlight(ThemeData theme, RefundSimulation sim) {
    final isPositive = sim.estimatedRefundInCents >= 0;
    final color =
        isPositive ? theme.colorScheme.primary : theme.colorScheme.error;
    final label = isPositive
        ? 'Economia estimada com deduções'
        : 'IR adicional estimado';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            _currency.format(sim.estimatedRefundInCents.abs() / 100),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdown(ThemeData theme, RefundSimulation sim) {
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        title: Text(
          'Ver detalhes',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        children: [
          _DetailRow(
            label: 'Base de cálculo',
            value: _currency.format(sim.taxableBaseInCents / 100),
          ),
          _DetailRow(
            label: 'IR sem deduções',
            value: _currency.format(sim.taxWithoutDeductionsInCents / 100),
          ),
          _DetailRow(
            label: 'IR com deduções',
            value: _currency.format(sim.taxWithDeductionsInCents / 100),
          ),
          _DetailRow(
            label: 'Alíquota efetiva',
            value: '${sim.effectiveRatePercent.toStringAsFixed(2)}%',
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
