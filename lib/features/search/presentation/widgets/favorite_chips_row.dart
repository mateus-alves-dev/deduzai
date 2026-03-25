import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/features/search/presentation/providers/search_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteChipsRow extends ConsumerWidget {
  const FavoriteChipsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favAsync = ref.watch(filterFavoritesProvider);

    return favAsync.when(
      data: (favs) {
        if (favs.isEmpty) return const SizedBox.shrink();
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: favs.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) => _FavoriteChip(fav: favs[i]),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _FavoriteChip extends ConsumerWidget {
  const _FavoriteChip({required this.fav});

  final FilterFavorite fav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialog(context, ref),
      child: ActionChip(
        label: Text(fav.nome),
        avatar: const Icon(Icons.bookmark_outline, size: 16),
        onPressed: () =>
            ref.read(searchNotifierProvider.notifier).applyFavorite(fav),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover favorito'),
        content: Text('Deseja remover "${fav.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(filterFavoriteDaoProvider).softDelete(fav.id);
            },
            child: const Text('Remover'),
          ),
        ],
      ),
    );
  }
}
