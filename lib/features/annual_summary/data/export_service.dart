import 'dart:io';

import 'package:csv/csv.dart';
import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'export_service.g.dart';

@riverpod
ExportService exportService(Ref ref) => const ExportService();

/// Generates PDF and CSV export files for a given [AnnualSummary].
class ExportService {
  const ExportService();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$',
  );
  static final _dateFormat = DateFormat('dd/MM/yyyy');
  static final _csvDateFormat = DateFormat('yyyy-MM-dd');
  static final _timestampFormat = DateFormat('yyyyMMdd_HHmmss');

  /// Generates a PDF report and saves it to the temp directory.
  ///
  /// Returns the generated [File]. Share it via `share_plus`.
  Future<File> generatePdf(
    AnnualSummary summary,
    List<Expense> expenses,
  ) async {
    final doc = pw.Document();
    final now = DateTime.now();

    final groupedByCategory = <DeductionCategory, List<Expense>>{};
    for (final expense in expenses) {
      final category = _parseCategory(expense.category);
      groupedByCategory.putIfAbsent(category, () => []).add(expense);
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (_) => _buildPdfHeader(summary.fiscalYear),
        footer: (ctx) => _buildPdfFooter(ctx, now),
        build: (ctx) => [
          ..._buildCategorySections(summary, groupedByCategory),
          pw.SizedBox(height: 16),
          _buildTotalRow(summary),
        ],
      ),
    );

    final bytes = await doc.save();
    final dir = await getTemporaryDirectory();
    final fileName =
        'DeduzAi_IR_${summary.fiscalYear}_${_timestampFormat.format(now)}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Generates a CSV export and saves it to the temp directory.
  ///
  /// Returns the generated [File]. Share it via `share_plus`.
  Future<File> generateCsv(
    List<Expense> expenses,
    int fiscalYear,
  ) async {
    final rows = <List<dynamic>>[
      // Header row
      [
        'data',
        'categoria',
        'beneficiario',
        'cnpj',
        'valor',
        'descricao',
        'tem_comprovante',
      ],
      ...expenses.map((e) {
        final amountReais = e.amountInCents / 100;
        return [
          _csvDateFormat.format(e.date),
          _parseCategory(e.category).label,
          e.beneficiario ?? '',
          e.cnpj ?? '',
          amountReais.toStringAsFixed(2),
          e.description,
          if (e.receiptPath != null) 'sim' else 'nao',
        ];
      }),
    ];

    final csvContent = const CsvEncoder().convert(rows);
    // UTF-8 BOM for Excel compatibility (Spec 5.4)
    const bom = '\uFEFF';
    final now = DateTime.now();
    final dir = await getTemporaryDirectory();
    final fileName =
        'DeduzAi_IR_${fiscalYear}_${_timestampFormat.format(now)}.csv';
    final file = File('${dir.path}/$fileName');
    await file.writeAsString('$bom$csvContent');
    return file;
  }

  // ── PDF helpers ──────────────────────────────────────────────────────────

  pw.Widget _buildPdfHeader(int fiscalYear) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'DeduzAí — Resumo IR $fiscalYear',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'CPF: ***.***.***-**',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
        pw.Divider(thickness: 1, color: PdfColors.grey400),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildPdfFooter(pw.Context ctx, DateTime generatedAt) {
    return pw.Column(
      children: [
        pw.Divider(thickness: 0.5, color: PdfColors.grey400),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Documento gerado pelo DeduzAí em '
              '${_dateFormat.format(generatedAt)}. '
              'Guarde os comprovantes originais.',
              style: const pw.TextStyle(
                fontSize: 8,
                color: PdfColors.grey600,
              ),
            ),
            pw.Text(
              'Pág. ${ctx.pageNumber} / ${ctx.pagesCount}',
              style: const pw.TextStyle(
                fontSize: 8,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _buildCategorySections(
    AnnualSummary summary,
    Map<DeductionCategory, List<Expense>> grouped,
  ) {
    final widgets = <pw.Widget>[];

    for (final categorySummary in summary.categories) {
      final categoryExpenses =
          grouped[categorySummary.category] ?? [];

      widgets
        ..add(
          pw.Text(
            categorySummary.category.label,
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        )
        ..add(pw.SizedBox(height: 6))
        ..add(
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: {
              0: const pw.FixedColumnWidth(70),
              1: const pw.FlexColumnWidth(),
              2: const pw.FixedColumnWidth(90),
              3: const pw.FixedColumnWidth(30),
            },
            children: [
              _tableHeaderRow(),
              ...categoryExpenses.map(_tableDataRow),
            ],
          ),
        )
        ..add(pw.SizedBox(height: 4))
        ..add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Total ${categorySummary.category.label}: '
                '${_currencyFormat.format(categorySummary.totalInCents / 100)}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        );

      if (categorySummary.surplusInCents != null) {
        final deductible = _currencyFormat.format(
          categorySummary.deductibleInCents / 100,
        );
        final surplus = _currencyFormat.format(
          categorySummary.surplusInCents! / 100,
        );
        widgets.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Dedutível: $deductible (excedente: $surplus)',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.orange800,
                ),
              ),
            ],
          ),
        );
      }

      widgets.add(pw.SizedBox(height: 16));
    }

    return widgets;
  }

  pw.TableRow _tableHeaderRow() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
      children: ['Data', 'Beneficiário', 'Valor', 'Comp.']
          .map(
            (h) => pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                h,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  pw.TableRow _tableDataRow(Expense e) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            _dateFormat.format(e.date),
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            e.beneficiario ?? e.description,
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            _currencyFormat.format(e.amountInCents / 100),
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
            e.receiptPath != null ? 'Sim' : 'Não',
            style: const pw.TextStyle(fontSize: 9),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTotalRow(AnnualSummary summary) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: const pw.BoxDecoration(color: PdfColors.grey100),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: [
          pw.Text(
            'Total dedutível geral: '
            '${_currencyFormat.format(summary.totalDeductibleInCents / 100)}',
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  DeductionCategory _parseCategory(String raw) {
    return DeductionCategory.values.firstWhere(
      (c) => c.name == raw,
      orElse: () => DeductionCategory.saude,
    );
  }
}
