import 'dart:io';

import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:deduzai/features/receipt_gallery/presentation/providers/receipt_viewer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ArchivedReceiptsScreen extends ConsumerWidget {
  const ArchivedReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedAsync = ref.watch(archivedReceiptsWithExpenseProvider);

    return Scaffold(
      appBar: const DeduzaiAppBar(title: 'Comprovantes arquivados'),
      body: archivedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.archive_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Nenhum comprovante arquivado.',
                    style: AppTextStyles.titleMedium,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              final (:receipt, :expense) = items[i];
              final date =
                  DateFormat('dd/MM/yyyy').format(expense.date);
              final description = expense.description.isNotEmpty
                  ? expense.description
                  : expense.beneficiario ?? 'Gasto excluído';

              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(
                      File(receipt.localPath),
                      width: 56,
                      height: 56,
                      cacheWidth: 112,
                      cacheHeight: 112,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.broken_image_outlined),
                      ),
                    ),
                  ),
                  title: Text(
                    description,
                    style: AppTextStyles.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(date, style: AppTextStyles.bodyMedium),
                  trailing: IconButton(
                    icon: const Icon(Icons.share_outlined),
                    tooltip: 'Compartilhar',
                    onPressed: () async {
                      try {
                        await SharePlus.instance.share(
                          ShareParams(
                            files: [XFile(receipt.localPath)],
                            subject: 'Comprovante de gasto — DeduzAí',
                          ),
                        );
                      } on Exception catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Arquivo não encontrado.'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
