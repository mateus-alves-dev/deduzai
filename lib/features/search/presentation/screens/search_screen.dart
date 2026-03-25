import 'dart:convert';

import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/search_filter.dart';
import 'package:deduzai/features/expense_list/presentation/widgets/expense_list_tile.dart';
import 'package:deduzai/features/search/presentation/providers/search_providers.dart';
import 'package:deduzai/features/search/presentation/widgets/favorite_chips_row.dart';
import 'package:deduzai/features/search/presentation/widgets/filter_panel.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _queryCtrl = TextEditingController();
  bool _showFilters = false;

  @override
  void dispose() {
    _queryCtrl.dispose();
    // Reset filter state when leaving
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(searchNotifierProvider);
    final notifier = ref.read(searchNotifierProvider.notifier);
    final resultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar gastos'),
        actions: [
          IconButton(
            icon: Icon(
              filter.sortOrder != SearchSortOrder.dateDesc
                  ? Icons.sort
                  : Icons.sort_outlined,
            ),
            tooltip: 'Ordenação',
            onPressed: () => _showSortDialog(context, filter, notifier),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined),
            tooltip: 'Salvar favorito',
            onPressed:
                filter.hasActiveFilters ? () => _saveFavorite(context) : null,
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search field ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _queryCtrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar por nome, beneficiário...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _queryCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _queryCtrl.clear();
                          notifier.setQuery('');
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          _showFilters
                              ? Icons.filter_list
                              : Icons.filter_list_outlined,
                        ),
                        tooltip: 'Filtros',
                        onPressed: () =>
                            setState(() => _showFilters = !_showFilters),
                      ),
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: notifier.setQuery,
            ),
          ),

          // ── Favorites row ─────────────────────────────────────────────────
          const FavoriteChipsRow(),
          const SizedBox(height: 4),

          // ── Filter panel ──────────────────────────────────────────────────
          if (_showFilters)
            Expanded(
              flex: 0,
              child: SingleChildScrollView(
                child: const FilterPanel(),
              ),
            ),

          // ── Results ───────────────────────────────────────────────────────
          Expanded(
            child: resultsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Erro ao buscar: $e')),
              data: (expenses) {
                if (expenses.isEmpty) {
                  return _EmptyResults(
                    hasFilter: filter.hasActiveFilters,
                    onClear: () {
                      notifier.clearAll();
                      _queryCtrl.clear();
                    },
                  );
                }
                return _ResultsList(expenses: expenses);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSortDialog(
    BuildContext context,
    SearchFilter filter,
    SearchNotifier notifier,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text(
                'Ordenar por',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            for (final order in SearchSortOrder.values)
              RadioListTile<SearchSortOrder>(
                title: Text(_sortLabel(order)),
                value: order,
                groupValue: filter.sortOrder,
                onChanged: (v) {
                  if (v != null) notifier.setSortOrder(v);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  String _sortLabel(SearchSortOrder order) => switch (order) {
        SearchSortOrder.dateDesc => 'Data (mais recente)',
        SearchSortOrder.dateAsc => 'Data (mais antigo)',
        SearchSortOrder.amountDesc => 'Valor (maior)',
        SearchSortOrder.amountAsc => 'Valor (menor)',
        SearchSortOrder.categoryAz => 'Categoria (A–Z)',
      };

  Future<void> _saveFavorite(BuildContext context) async {
    final filter = ref.read(searchNotifierProvider);
    final count = await ref.read(filterFavoriteDaoProvider).count();
    if (count >= 10) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Limite de 10 favoritos atingido. Remova um para continuar.'),
          ),
        );
      }
      return;
    }

    final nameCtrl = TextEditingController(
      text: _buildSuggestedName(filter),
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Salvar favorito'),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    final name = nameCtrl.text.trim();
    if (name.isEmpty) return;

    final categoriesJson = filter.categories.isEmpty
        ? null
        : jsonEncode(filter.categories.map((c) => c.name).toList());

    await ref.read(filterFavoriteDaoProvider).insert(
          FilterFavoritesCompanion.insert(
            id: const Uuid().v4(),
            nome: name,
            categorias: Value(categoriesJson),
            dataInicio: Value(filter.dateFrom),
            dataFim: Value(filter.dateTo),
            valorMin: Value(filter.amountMinCents),
            valorMax: Value(filter.amountMaxCents),
            comComprovante: Value(
              filter.receiptFilter == SearchReceiptFilter.all
                  ? null
                  : filter.receiptFilter == SearchReceiptFilter.withReceipt,
            ),
            criadoEm: DateTime.now(),
            atualizadoEm: DateTime.now(),
          ),
        );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Favorito "$name" salvo!')),
      );
    }
  }

  String _buildSuggestedName(SearchFilter filter) {
    final parts = <String>[];
    if (filter.categories.isNotEmpty) {
      parts.add(filter.categories.first.label);
    }
    if (filter.dateFrom != null) {
      final year = filter.dateFrom!.year;
      parts.add(year.toString());
    }
    if (parts.isEmpty && filter.query.isNotEmpty) {
      parts.add(filter.query);
    }
    return parts.join(' ');
  }
}

class _ResultsList extends StatelessWidget {
  const _ResultsList({required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');
    final total = expenses.fold<int>(0, (s, e) => s + e.amountInCents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(
            'Encontrados: ${expenses.length}  •  ${currency.format(total / 100)}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, i) {
              final expense = expenses[i];
              return ExpenseListTile(
                expense: expense,
                onTap: () => context.push('/expenses/${expense.id}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.hasFilter, required this.onClear});

  final bool hasFilter;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: 16),
            Text(
              hasFilter
                  ? 'Nenhum gasto encontrado.'
                  : 'Digite para buscar ou use os filtros.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (hasFilter) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear_all),
                label: const Text('Limpar filtros'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
