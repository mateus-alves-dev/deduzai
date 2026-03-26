import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/domain/models/relationship.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/dependents/domain/dependent_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Bottom sheet for creating or editing a dependent.
class DependentFormSheet extends ConsumerStatefulWidget {
  const DependentFormSheet({this.dependent, super.key});

  final Dependent? dependent;

  bool get isEditing => dependent != null;

  /// Shows the form as a modal bottom sheet.
  static Future<void> show(
    BuildContext context, {
    Dependent? dependent,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => DependentFormSheet(dependent: dependent),
  );

  @override
  ConsumerState<DependentFormSheet> createState() => _DependentFormSheetState();
}

class _DependentFormSheetState extends ConsumerState<DependentFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  Relationship _relationship = Relationship.filho;
  DateTime? _birthDate;
  bool _saving = false;

  static final _dateFmt = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    final d = widget.dependent;
    _nameController = TextEditingController(text: d?.name ?? '');
    if (d != null) {
      _relationship = Relationship.fromValue(d.relationship);
      _birthDate = d.birthDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      useRootNavigator: true,
      initialDate: _birthDate ?? DateTime(now.year - 5),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_birthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe a data de nascimento')),
      );
      return;
    }

    setState(() => _saving = true);
    final birthDate = _birthDate!;
    try {
      final service = ref.read(dependentServiceProvider);
      if (widget.isEditing) {
        await service.update(
          existing: widget.dependent!,
          name: _nameController.text.trim(),
          relationship: _relationship,
          birthDate: birthDate,
        );
      } else {
        await service.create(
          name: _nameController.text.trim(),
          relationship: _relationship,
          birthDate: birthDate,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover dependente?'),
        content: Text(
          'O dependente "${widget.dependent!.name}" será removido '
          'e não contará mais na simulação.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await ref.read(dependentServiceProvider).softDelete(widget.dependent!.id);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                Text(
                  widget.isEditing
                      ? 'Editar dependente'
                      : 'Adicionar dependente',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                ),
                const SizedBox(height: AppSpacing.md),
                DropdownButtonFormField<Relationship>(
                  initialValue: _relationship,
                  decoration: const InputDecoration(
                    labelText: 'Parentesco',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.family_restroom_outlined),
                  ),
                  items: Relationship.values
                      .map(
                        (r) => DropdownMenuItem(
                          value: r,
                          child: Text(r.label),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _relationship = v);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(4),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Data de nascimento',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake_outlined),
                    ),
                    child: Text(
                      _birthDate != null
                          ? _dateFmt.format(_birthDate!)
                          : 'Selecionar data',
                      style: _birthDate != null
                          ? null
                          : theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.isEditing ? 'Salvar' : 'Adicionar'),
                ),
                if (widget.isEditing) ...[
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: _saving ? null : _confirmDelete,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                    ),
                    child: const Text('Remover dependente'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
