import 'dart:io';

import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/features/annual_summary/data/export_service.dart';
import 'package:deduzai/features/annual_summary/presentation/providers/annual_summary_provider.dart';
import 'package:deduzai/features/annual_summary/presentation/widgets/category_summary_card.dart';
import 'package:deduzai/features/annual_summary/presentation/widgets/year_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class AnnualSummaryScreen extends ConsumerStatefulWidget {
  const AnnualSummaryScreen({super.key});

  @override
  ConsumerState<AnnualSummaryScreen> createState() =>
      _AnnualSummaryScreenState();
}

class _AnnualSummaryScreenState extends ConsumerState<AnnualSummaryScreen> {
  bool _exportingPdf = false;
  bool _exportingCsv = false;

  static final _currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );

  @override
  Widget build(BuildContext context) {
    final year = ref.watch(selectedYearProvider);
    final summaryAsync = ref.watch(annualSummaryProvider(year));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo Anual'),
        actions: summaryAsync.maybeWhen(
          data: (summary) => summary.isEmpty
              ? null
              : [
                  _ExportButton(
                    icon: Icons.picture_as_pdf_outlined,
                    tooltip: 'Exportar PDF',
                    loading: _exportingPdf,
                    onPressed: () => _exportPdf(summary, year),
                  ),
                  _ExportButton(
                    icon: Icons.table_chart_outlined,
                    tooltip: 'Exportar CSV',
                    loading: _exportingCsv,
                    onPressed: () => _exportCsv(year),
                  ),
                  const SizedBox(width: 4),
                ],
          orElse: () => null,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          YearSelector(
            year: year,
            onChanged: (y) =>
                ref.read(selectedYearProvider.notifier).select(y),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: summaryAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text('Erro ao carregar resumo: $e'),
              ),
              data: (summary) => summary.isEmpty
                  ? _EmptyState(year: year)
                  : _SummaryBody(summary: summary, currency: _currency),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportPdf(AnnualSummary summary, int year) async {
    setState(() => _exportingPdf = true);
    try {
      final expenses = await ref.read(expensesForYearProvider(year).future);
      final service = ref.read(exportServiceProvider);
      final file = await service.generatePdf(summary, expenses);
      await _share(file, 'application/pdf');
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao gerar PDF: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingPdf = false);
    }
  }

  Future<void> _exportCsv(int year) async {
    setState(() => _exportingCsv = true);
    try {
      final expenses = await ref.read(expensesForYearProvider(year).future);
      final service = ref.read(exportServiceProvider);
      final file = await service.generateCsv(expenses, year);
      await _share(file, 'text/csv');
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao gerar CSV: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingCsv = false);
    }
  }

  Future<void> _share(File file, String mimeType) async {
    await Share.shareXFiles(
      [XFile(file.path, mimeType: mimeType)],
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({
    required this.summary,
    required this.currency,
  });

  final AnnualSummary summary;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    final cappedCategories =
        summary.categories.where((c) => c.surplusInCents != null).toList();

    return ListView(
      children: [
        if (cappedCategories.isNotEmpty)
          _CapWarningBanner(
            summaries: cappedCategories,
            currency: currency,
          ),
        ...summary.categories.map((c) => CategorySummaryCard(summary: c)),
        const SizedBox(height: 8),
        _TotalCard(summary: summary, currency: currency),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _CapWarningBanner extends StatelessWidget {
  const _CapWarningBanner({
    required this.summaries,
    required this.currency,
  });

  final List<CategorySummary> summaries;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalSurplus = summaries.fold(
      0,
      (sum, s) => sum + (s.surplusInCents ?? 0),
    );
    final categoryLabels =
        summaries.map((s) => s.category.label).join(', ');

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: theme.colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Você ultrapassou o teto de dedução em $categoryLabels. '
              'O excedente de ${currency.format(totalSurplus / 100)} '
              'não será dedutível.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.summary, required this.currency});

  final AnnualSummary summary;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total dedutível',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            Text(
              currency.format(summary.totalDeductibleInCents / 100),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.year});

  final int year;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bar_chart_outlined,
            size: 64,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum gasto registrado em $year.',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Registrar primeiro gasto'),
            onPressed: () => context.push('/expenses/new'),
          ),
        ],
      ),
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({
    required this.icon,
    required this.tooltip,
    required this.loading,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
