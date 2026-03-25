import 'dart:io';

import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:deduzai/features/receipt_gallery/presentation/providers/receipt_viewer_provider.dart';
import 'package:deduzai/features/receipt_gallery/presentation/widgets/receipt_metadata_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptViewerScreen extends ConsumerStatefulWidget {
  const ReceiptViewerScreen({required this.expenseId, super.key});

  final String expenseId;

  @override
  ConsumerState<ReceiptViewerScreen> createState() =>
      _ReceiptViewerScreenState();
}

class _ReceiptViewerScreenState extends ConsumerState<ReceiptViewerScreen> {
  bool _isAttaching = false;

  // Spec 4.3: open camera and attach receipt to existing expense
  Future<void> _openCameraForAttach() async {
    setState(() => _isAttaching = true);
    try {
      final result = await context.push<OcrResult>('/camera');
      if (result == null || !mounted) return;

      await ref.read(expenseServiceProvider).attachReceipt(
        expenseId: widget.expenseId,
        imagePath: result.imagePath,
        ocrStatus: result.status,
      );

      if (!mounted) return;

      // Check for valor mismatch (Spec 4.3)
      if (result.valor != null) {
        final expense = await ref
            .read(expenseDaoProvider)
            .watchById(widget.expenseId)
            .first;
        if (expense != null && result.valor != expense.amountInCents) {
          _showValorMismatchDialog(result.valor!, expense);
        }
      }
    } finally {
      if (mounted) setState(() => _isAttaching = false);
    }
  }

  Future<void> _shareReceipt(String path) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(path)],
          subject: 'Comprovante de gasto — DeduzAí',
        ),
      );
    } on Exception catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Arquivo não encontrado.')),
        );
      }
    }
  }

  void _showValorMismatchDialog(int ocrValor, Expense expense) {
    final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Valor diferente'),
        content: Text(
          'O valor na nota (${fmt.format(ocrValor / 100)}) é diferente do '
          'registrado (${fmt.format(expense.amountInCents / 100)}). '
          'Deseja atualizar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Manter atual'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(expenseServiceProvider).updateExpense(
                existing: expense,
                date: expense.date,
                category: DeductionCategory.values.byName(expense.category),
                amountInCents: ocrValor,
                description: expense.description,
                beneficiario: expense.beneficiario,
                cnpj: expense.cnpj,
              );
            },
            child: const Text('Atualizar valor'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final receiptsAsync =
        ref.watch(receiptsByExpenseProvider(widget.expenseId));
    final expenseAsync =
        ref.watch(receiptViewerExpenseProvider(widget.expenseId));

    final hasReceipt =
        receiptsAsync.value?.isNotEmpty ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprovante'),
        actions: [
          if (hasReceipt)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              tooltip: 'Compartilhar',
              onPressed: () {
                final path = receiptsAsync.value!.first.localPath;
                _shareReceipt(path);
              },
            ),
        ],
      ),
      body: receiptsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (receipts) {
          if (receipts.isEmpty) return _buildEmpty();
          return _buildViewer(receipts.first, expenseAsync);
        },
      ),
    );
  }

  // Spec 4.2: empty state
  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Nenhum comprovante anexado',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Adicione uma foto da nota fiscal.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: _isAttaching ? null : _openCameraForAttach,
              icon: const Icon(Icons.add_a_photo_outlined),
              label: _isAttaching
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Adicionar comprovante agora'),
            ),
          ],
        ),
      ),
    );
  }

  // Spec 4.1: full-screen viewer with zoom + share
  Widget _buildViewer(
    Receipt receipt,
    AsyncValue<Expense?> expenseAsync,
  ) {
    return Column(
      children: [
        Expanded(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 5,
            child: Image.file(
              File(receipt.localPath),
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Center(
                child: Icon(Icons.broken_image_outlined, size: 64),
              ),
            ),
          ),
        ),
        expenseAsync.whenData(
          (expense) => expense != null
              ? ReceiptMetadataPanel(expense: expense)
              : const SizedBox.shrink(),
        ).value ?? const SizedBox.shrink(),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: TextButton.icon(
              onPressed: () => _shareReceipt(receipt.localPath),
              icon: const Icon(Icons.share_outlined),
              label: const Text('Compartilhar'),
            ),
          ),
        ),
      ],
    );
  }
}
