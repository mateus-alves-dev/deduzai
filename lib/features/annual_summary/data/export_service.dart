import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/annual_summary.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:flutter/foundation.dart' show compute, visibleForTesting;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'export_service.g.dart';

@riverpod
ExportService exportService(Ref ref) => const ExportService();

/// Font bytes loaded from assets, passed to the background isolate.
@visibleForTesting
class PdfFontBundle {
  /// Creates a bundle of font byte data for PDF generation.
  const PdfFontBundle({
    required this.regular,
    required this.semiBold,
    required this.bold,
  });

  /// Regular weight font bytes.
  final ByteData regular;

  /// SemiBold weight font bytes.
  final ByteData semiBold;

  /// Bold weight font bytes.
  final ByteData bold;
}

/// Resolved [pw.Font] instances created inside the isolate.
class _PdfFonts {
  _PdfFonts(PdfFontBundle bundle)
      : regular = pw.Font.ttf(bundle.regular),
        semiBold = pw.Font.ttf(bundle.semiBold),
        bold = pw.Font.ttf(bundle.bold);

  final pw.Font regular;
  final pw.Font semiBold;
  final pw.Font bold;
}

/// Top-level function for [compute] — builds PDF bytes in a background isolate.
Future<Uint8List> _buildPdfInIsolate(
  (AnnualSummary, List<Expense>, DateTime, PdfFontBundle) args,
) {
  final (summary, expenses, now, fonts) = args;
  return const ExportService()
      .buildPdfBytes(summary, expenses, now, fonts);
}

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

  // ── Design tokens ────────────────────────────────────────────────────────

  static final _green800 = PdfColor.fromHex('#2E7D32');
  static final _green700 = PdfColor.fromHex('#388E3C');
  static final _green50 = PdfColor.fromHex('#E8F5E9');
  static final _grey50 = PdfColor.fromHex('#FAFAFA');
  static final _grey100 = PdfColor.fromHex('#F5F5F5');
  static final _grey200 = PdfColor.fromHex('#EEEEEE');
  static final _grey500 = PdfColor.fromHex('#9E9E9E');
  static final _textPrimary = PdfColor.fromHex('#212121');
  static final _textSecondary = PdfColor.fromHex('#757575');
  static final _amber700 = PdfColor.fromHex('#FFA000');

  /// Color for each [DeductionCategory] — used in section badges.
  static final _categoryColors = <DeductionCategory, PdfColor>{
    DeductionCategory.saude: PdfColor.fromHex('#E53935'),
    DeductionCategory.educacao: PdfColor.fromHex('#1E88E5'),
    DeductionCategory.pensaoAlimenticia: PdfColor.fromHex('#8E24AA'),
    DeductionCategory.previdenciaPrivada: PdfColor.fromHex('#00897B'),
    DeductionCategory.dependentes: PdfColor.fromHex('#F4511E'),
    DeductionCategory.previdenciaSocial: PdfColor.fromHex('#3949AB'),
    DeductionCategory.doacoesIncentivadas: PdfColor.fromHex('#D81B60'),
    DeductionCategory.livroCaixa: PdfColor.fromHex('#6D4C41'),
  };

  /// First letter of each category label for the badge.
  static String _categoryInitial(DeductionCategory cat) =>
      cat.label[0].toUpperCase();

  // ── PDF generation ───────────────────────────────────────────────────────

  /// Generates a PDF report and saves it to the temp directory.
  ///
  /// Font assets are loaded from the bundle and passed to a background
  /// isolate via [compute] so the UI stays responsive.
  Future<File> generatePdf(
    AnnualSummary summary,
    List<Expense> expenses,
  ) async {
    final now = DateTime.now();
    final fontBundle = PdfFontBundle(
      regular: await rootBundle.load('assets/fonts/Inter-Regular.ttf'),
      semiBold: await rootBundle.load('assets/fonts/Inter-SemiBold.ttf'),
      bold: await rootBundle.load('assets/fonts/Inter-Bold.ttf'),
    );
    final bytes = await compute(
      _buildPdfInIsolate,
      (summary, expenses, now, fontBundle),
    );
    final dir = await getTemporaryDirectory();
    final fileName =
        'DeduzAi_IR_${summary.fiscalYear}_${_timestampFormat.format(now)}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Builds the PDF document bytes (called from isolate).
  @visibleForTesting
  Future<Uint8List> buildPdfBytes(
    AnnualSummary summary,
    List<Expense> expenses,
    DateTime now,
    PdfFontBundle fontBundle,
  ) async {
    final fonts = _PdfFonts(fontBundle);
    final theme = pw.ThemeData.withFont(
      base: fonts.regular,
      bold: fonts.bold,
    );

    final doc = pw.Document(theme: theme);

    final groupedByCategory = <DeductionCategory, List<Expense>>{};
    for (final expense in expenses) {
      final category = _parseCategory(expense.category);
      groupedByCategory.putIfAbsent(category, () => []).add(expense);
    }

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 36),
        header: (_) => _buildPdfHeader(summary, now, fonts),
        footer: (ctx) => _buildPdfFooter(ctx, now, fonts),
        build: (ctx) => [
          ..._buildCategorySections(summary, groupedByCategory, fonts),
          pw.SizedBox(height: 20),
          _buildTotalRow(summary, fonts),
        ],
      ),
    );

    return doc.save();
  }

  // ── CSV generation ───────────────────────────────────────────────────────

  /// Generates a CSV export and saves it to the temp directory.
  ///
  /// Returns the generated [File]. Share it via `share_plus`.
  Future<File> generateCsv(
    List<Expense> expenses,
    int fiscalYear,
  ) async {
    final rows = <List<dynamic>>[
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

  // ── PDF header ───────────────────────────────────────────────────────────

  pw.Widget _buildPdfHeader(
    AnnualSummary summary,
    DateTime generatedAt,
    _PdfFonts fonts,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Thick green accent bar
        pw.Container(
          height: 6,
          decoration: pw.BoxDecoration(
            color: _green800,
            borderRadius: pw.BorderRadius.circular(3),
          ),
        ),
        pw.SizedBox(height: 14),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'DeduzAí',
                  style: pw.TextStyle(
                    font: fonts.bold,
                    fontSize: 22,
                    color: _green800,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'Relatório de Despesas Dedutíveis · IR ${summary.fiscalYear}',
                  style: pw.TextStyle(
                    font: fonts.regular,
                    fontSize: 10,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Gerado em ${_dateFormat.format(generatedAt)}',
                  style: pw.TextStyle(
                    font: fonts.regular,
                    fontSize: 8.5,
                    color: _grey500,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'CPF: ***.***.***-**',
                  style: pw.TextStyle(
                    font: fonts.regular,
                    fontSize: 8.5,
                    color: _grey500,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),
        // Summary quick-stats bar
        _buildQuickStats(summary, fonts),
        pw.SizedBox(height: 12),
        pw.Divider(thickness: 0.5, color: _grey200),
        pw.SizedBox(height: 8),
      ],
    );
  }

  /// Compact stats row: total expenses count, categories, total amount.
  pw.Widget _buildQuickStats(AnnualSummary summary, _PdfFonts fonts) {
    final totalExpenses = summary.categories.fold(0, (s, c) => s + c.count);

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: pw.BoxDecoration(
        color: _green50,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _statCell(
            'Despesas',
            totalExpenses.toString(),
            fonts,
          ),
          _statDivider(),
          _statCell(
            'Categorias',
            summary.categories.length.toString(),
            fonts,
          ),
          _statDivider(),
          _statCell(
            'Total Gasto',
            _currencyFormat.format(summary.totalInCents / 100),
            fonts,
          ),
          _statDivider(),
          _statCell(
            'Total Dedutível',
            _currencyFormat.format(summary.totalDeductibleInCents / 100),
            fonts,
            valueColor: _green800,
          ),
        ],
      ),
    );
  }

  pw.Widget _statCell(
    String label,
    String value,
    _PdfFonts fonts, {
    PdfColor? valueColor,
  }) {
    return pw.Column(
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            font: fonts.regular,
            fontSize: 7.5,
            color: _textSecondary,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: fonts.semiBold,
            fontSize: 10,
            color: valueColor ?? _textPrimary,
          ),
        ),
      ],
    );
  }

  pw.Widget _statDivider() {
    return pw.Container(
      width: 0.5,
      height: 24,
      color: _grey200,
    );
  }

  // ── PDF footer ───────────────────────────────────────────────────────────

  pw.Widget _buildPdfFooter(
    pw.Context ctx,
    DateTime generatedAt,
    _PdfFonts fonts,
  ) {
    return pw.Column(
      children: [
        pw.Divider(thickness: 0.5, color: _grey200),
        pw.SizedBox(height: 6),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'DeduzAí · ${_dateFormat.format(generatedAt)} · '
              'Guarde os comprovantes originais por no mínimo 5 anos.',
              style: pw.TextStyle(
                font: fonts.regular,
                fontSize: 7.5,
                color: _grey500,
              ),
            ),
            pw.Text(
              'Página ${ctx.pageNumber} de ${ctx.pagesCount}',
              style: pw.TextStyle(
                font: fonts.regular,
                fontSize: 7.5,
                color: _grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Category sections ────────────────────────────────────────────────────

  List<pw.Widget> _buildCategorySections(
    AnnualSummary summary,
    Map<DeductionCategory, List<Expense>> grouped,
    _PdfFonts fonts,
  ) {
    final widgets = <pw.Widget>[];

    for (final categorySummary in summary.categories) {
      final categoryExpenses =
          grouped[categorySummary.category] ?? [];
      final catColor =
          _categoryColors[categorySummary.category] ?? _green700;
      final subtotalFormatted = _currencyFormat.format(
        categorySummary.totalInCents / 100,
      );
      final deductibleFmt = _currencyFormat.format(
        categorySummary.deductibleInCents / 100,
      );

      // ── Category heading with colored badge ──
      widgets
        ..add(
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 4),
            child: pw.Row(
              children: [
                // Colored circle badge with initial
                pw.Container(
                  width: 22,
                  height: 22,
                  decoration: pw.BoxDecoration(
                    color: catColor,
                    shape: pw.BoxShape.circle,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    _categoryInitial(categorySummary.category),
                    style: pw.TextStyle(
                      font: fonts.bold,
                      fontSize: 10,
                      color: PdfColors.white,
                    ),
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Expanded(
                  child: pw.Text(
                    categorySummary.category.label,
                    style: pw.TextStyle(
                      font: fonts.semiBold,
                      fontSize: 12,
                      color: _textPrimary,
                    ),
                  ),
                ),
                pw.Text(
                  '${categorySummary.count} '
                  '${categorySummary.count == 1 ? 'despesa' : 'despesas'}',
                  style: pw.TextStyle(
                    font: fonts.regular,
                    fontSize: 8,
                    color: _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        )
        ..add(pw.SizedBox(height: 8))
        // ── Expense table (clean, minimal borders) ──
        ..add(
          pw.Table(
            border: pw.TableBorder(
              horizontalInside:
                  pw.BorderSide(color: _grey200, width: 0.5),
              bottom: pw.BorderSide(color: _grey200, width: 0.5),
            ),
            columnWidths: {
              0: const pw.FixedColumnWidth(68),
              1: const pw.FlexColumnWidth(),
              2: const pw.FixedColumnWidth(85),
              3: const pw.FixedColumnWidth(34),
            },
            children: [
              _tableHeaderRow(fonts, catColor),
              ...categoryExpenses.indexed.map(
                (entry) =>
                    _tableDataRow(entry.$2, entry.$1, fonts),
              ),
            ],
          ),
        )
        ..add(pw.SizedBox(height: 6))
        // ── Subtotal box ──
        ..add(
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                color: _grey100,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'Total '
                    '${categorySummary.category.label}: '
                    '$subtotalFormatted',
                    style: pw.TextStyle(
                      font: fonts.semiBold,
                      fontSize: 9.5,
                      color: _textPrimary,
                    ),
                  ),
                  if (categorySummary.surplusInCents !=
                      null) ...[
                    pw.SizedBox(height: 3),
                    pw.Row(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Text(
                          'Dedutível: $deductibleFmt',
                          style: pw.TextStyle(
                            font: fonts.regular,
                            fontSize: 8,
                            color: _textSecondary,
                          ),
                        ),
                        pw.SizedBox(width: 8),
                        _surplusBadge(
                          categorySummary.surplusInCents!,
                          fonts,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        )
        ..add(pw.SizedBox(height: 18));
    }

    return widgets;
  }

  pw.Widget _surplusBadge(int surplusInCents, _PdfFonts fonts) {
    final formatted = _currencyFormat.format(
      surplusInCents / 100,
    );
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 1.5,
      ),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#FFF3E0'),
        borderRadius: pw.BorderRadius.circular(3),
      ),
      child: pw.Text(
        'Excedente: $formatted',
        style: pw.TextStyle(
          font: fonts.semiBold,
          fontSize: 7.5,
          color: _amber700,
        ),
      ),
    );
  }

  pw.TableRow _tableHeaderRow(_PdfFonts fonts, PdfColor accentColor) {
    pw.Widget cell(String text, {pw.Alignment? align}) {
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        alignment: align,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            font: fonts.semiBold,
            fontSize: 8,
            color: _textSecondary,
          ),
        ),
      );
    }

    return pw.TableRow(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: accentColor, width: 1.5),
        ),
      ),
      children: [
        cell('DATA'),
        cell('BENEFICIÁRIO / CNPJ'),
        cell('VALOR', align: pw.Alignment.centerRight),
        cell('COMP.', align: pw.Alignment.center),
      ],
    );
  }

  pw.TableRow _tableDataRow(Expense e, int index, _PdfFonts fonts) {
    final rowColor = index.isOdd ? _grey50 : PdfColors.white;
    final hasCnpj = e.cnpj != null && e.cnpj!.isNotEmpty;

    return pw.TableRow(
      decoration: pw.BoxDecoration(color: rowColor),
      children: [
        // Date
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: pw.Text(
            _dateFormat.format(e.date),
            style: pw.TextStyle(
              font: fonts.regular,
              fontSize: 8.5,
              color: _textPrimary,
            ),
          ),
        ),
        // Beneficiary + CNPJ
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                e.beneficiario ?? e.description,
                style: pw.TextStyle(
                  font: fonts.regular,
                  fontSize: 8.5,
                  color: _textPrimary,
                ),
              ),
              if (hasCnpj)
                pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 1),
                  child: pw.Text(
                    _formatCnpj(e.cnpj!),
                    style: pw.TextStyle(
                      font: fonts.regular,
                      fontSize: 7,
                      color: _grey500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Amount (right-aligned)
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            _currencyFormat.format(e.amountInCents / 100),
            style: pw.TextStyle(
              font: fonts.regular,
              fontSize: 8.5,
              color: _textPrimary,
            ),
          ),
        ),
        // Receipt indicator
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          alignment: pw.Alignment.center,
          child: pw.Container(
            width: 14,
            height: 14,
            decoration: pw.BoxDecoration(
              color: e.receiptPath != null
                  ? PdfColor.fromHex('#E8F5E9')
                  : PdfColor.fromHex('#FBE9E7'),
              shape: pw.BoxShape.circle,
            ),
            alignment: pw.Alignment.center,
            child: pw.Text(
              e.receiptPath != null ? 'S' : 'N',
              style: pw.TextStyle(
                font: fonts.bold,
                fontSize: 6.5,
                color: e.receiptPath != null
                    ? _green800
                    : PdfColor.fromHex('#D84315'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Grand total ──────────────────────────────────────────────────────────

  pw.Widget _buildTotalRow(AnnualSummary summary, _PdfFonts fonts) {
    final formatted = _currencyFormat.format(
      summary.totalDeductibleInCents / 100,
    );
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: pw.BoxDecoration(
        color: _green800,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Total Dedutível Geral',
            style: pw.TextStyle(
              font: fonts.semiBold,
              fontSize: 13,
              color: PdfColors.white,
            ),
          ),
          pw.Text(
            formatted,
            style: pw.TextStyle(
              font: fonts.bold,
              fontSize: 15,
              color: PdfColors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared helpers ───────────────────────────────────────────────────────

  String _formatCnpj(String raw) {
    final d = raw.replaceAll(RegExp(r'\D'), '');
    if (d.length != 14) return raw;
    return '${d.substring(0, 2)}.${d.substring(2, 5)}.${d.substring(5, 8)}'
        '/${d.substring(8, 12)}-${d.substring(12)}';
  }

  DeductionCategory _parseCategory(String raw) {
    return DeductionCategory.values.firstWhere(
      (c) => c.name == raw,
      orElse: () => DeductionCategory.saude,
    );
  }
}
