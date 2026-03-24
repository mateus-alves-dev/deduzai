import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:deduzai/features/expense_entry/presentation/providers/expense_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}

class ExpenseFormScreen extends ConsumerStatefulWidget {
  const ExpenseFormScreen({super.key, this.expenseId});

  final String? expenseId;

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _beneficiarioController;
  late final TextEditingController _dateDisplayController;

  DeductionCategory? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  db.Expense? _existingExpense;
  bool _initialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _beneficiarioController = TextEditingController();
    _dateDisplayController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(_selectedDate),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _beneficiarioController.dispose();
    _dateDisplayController.dispose();
    super.dispose();
  }

  void _populateFromExpense(db.Expense expense) {
    if (_initialized) return;
    final amount = expense.amountInCents / 100;
    _amountController.text = NumberFormat('#,##0.00', 'pt_BR').format(amount);
    _descriptionController.text = expense.description;
    _beneficiarioController.text = expense.beneficiario ?? '';
    _selectedCategory = DeductionCategory.values.byName(expense.category);
    _selectedDate = expense.date;
    _dateDisplayController.text = DateFormat('dd/MM/yyyy').format(expense.date);
    _existingExpense = expense;
    _initialized = true;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe um valor maior que zero';
    }
    final parsed = double.tryParse(
      value.replaceAll('.', '').replaceAll(',', '.'),
    );
    if (parsed == null || parsed <= 0) {
      return 'Informe um valor maior que zero';
    }
    return null;
  }

  String? _validateDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    if (selected.isAfter(today)) {
      return 'A data não pode ser futura';
    }
    return null;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateDisplayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _submit() async {
    final dateError = _validateDate();
    if (!_formKey.currentState!.validate() || dateError != null) {
      if (dateError != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dateError)));
      }
      return;
    }

    setState(() => _isSaving = true);
    try {
      final rawAmount = _amountController.text
          .replaceAll('.', '')
          .replaceAll(',', '.');
      final amountInCents = (double.parse(rawAmount) * 100).round();
      final service = ref.read(expenseServiceProvider);

      if (widget.expenseId == null) {
        await service.createExpense(
          date: _selectedDate,
          category: _selectedCategory!,
          amountInCents: amountInCents,
          description: _descriptionController.text.trim(),
          beneficiario: _beneficiarioController.text.trim().nullIfEmpty,
        );
      } else {
        await service.updateExpense(
          existing: _existingExpense!,
          date: _selectedDate,
          category: _selectedCategory!,
          amountInCents: amountInCents,
          description: _descriptionController.text.trim(),
          beneficiario: _beneficiarioController.text.trim().nullIfEmpty,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gasto salvo ✓'),
            duration: Duration(seconds: 2),
          ),
        );
        context.pop();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir gasto?'),
        content: const Text('O gasto será removido da listagem.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && mounted) {
      await ref.read(expenseServiceProvider).deleteExpense(widget.expenseId!);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(expenseFormProvider(widget.expenseId), (_, next) {
      next.whenData((expense) {
        if (expense != null) {
          setState(() => _populateFromExpense(expense));
        }
      });
    });

    final formAsync = ref.watch(expenseFormProvider(widget.expenseId));

    return formAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(
          title: Text(widget.expenseId != null ? 'Editar Gasto' : 'Novo Gasto'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(child: Text('Erro ao carregar gasto: $e')),
      ),
      data: (_) => _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expenseId != null ? 'Editar Gasto' : 'Novo Gasto'),
        actions: [
          if (widget.expenseId != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Excluir gasto',
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Valor
                    TextFormField(
                      key: const Key('amountField'),
                      controller: _amountController,
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9,.]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        prefixText: r'R$ ',
                        hintText: '0,00',
                      ),
                      validator: _validateAmount,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Categoria
                    DropdownButtonFormField<DeductionCategory>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Categoria'),
                      items: DeductionCategory.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _selectedCategory = v),
                      validator: (v) =>
                          v == null ? 'Selecione uma categoria' : null,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Data
                    TextFormField(
                      controller: _dateDisplayController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Data',
                        suffixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      onTap: _pickDate,
                      validator: (_) => _validateDate(),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Descrição (opcional)
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição (opcional)',
                      ),
                      maxLines: 2,
                      maxLength: 255,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Beneficiário (opcional)
                    TextFormField(
                      controller: _beneficiarioController,
                      decoration: const InputDecoration(
                        labelText: 'Beneficiário (opcional)',
                        hintText: 'Ex: Clínica São Lucas',
                      ),
                      maxLength: 255,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Save button anchored at bottom
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: FilledButton(
                onPressed: _isSaving ? null : _submit,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Salvar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
