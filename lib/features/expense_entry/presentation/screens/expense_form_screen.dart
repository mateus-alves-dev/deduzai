import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/features/expense_entry/domain/cnpj_categorization_service.dart';
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
  late DateTime _selectedDate;
  db.Expense? _existingExpense;
  bool _initialized = false;
  bool _isSaving = false;

  // OCR state
  OcrResult? _ocrResult;
  // Tracks which fields were prefilled by OCR
  final Set<String> _ocrFilledFields = {};
  String? _ocrMessage;
  String? _cnpj;

  // CNPJ auto-categorization state (F3)
  bool _categorySuggested = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
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
    _cnpj = expense.cnpj;
    _initialized = true;
    // Attempt to suggest a category if this expense has a CNPJ but editing
    // it might benefit from the user's learned preference.
    if (expense.cnpj != null) _tryAutoCategory(expense.cnpj);
  }

  Future<void> _tryAutoCategory(String? cnpj) async {
    if (cnpj == null || cnpj.isEmpty) return;
    final service = ref.read(cnpjCategorizationServiceProvider);
    final suggestion = await service.suggestCategory(cnpj);
    if (suggestion != null && mounted) {
      setState(() {
        _selectedCategory = suggestion;
        _categorySuggested = true;
      });
    }
  }

  void _applyOcrResult(OcrResult result) {
    setState(() {
      _ocrResult = result;
      _ocrFilledFields.clear();

      if (result.valor != null) {
        final amount = result.valor! / 100;
        _amountController.text = NumberFormat(
          '#,##0.00',
          'pt_BR',
        ).format(amount);
        _ocrFilledFields.add('valor');
      }
      if (result.data != null) {
        _selectedDate = result.data!;
        _dateDisplayController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(result.data!);
        _ocrFilledFields.add('data');
      }
      if (result.cnpj != null) {
        _cnpj = result.cnpj;
        // Reset suggestion flag before the async call updates it.
        _categorySuggested = false;
      }
      if (result.beneficiario != null) {
        _beneficiarioController.text = result.beneficiario!;
        _ocrFilledFields.add('beneficiario');
      }

      _ocrMessage = switch (result.status) {
        OcrStatus.partial =>
          'Alguns campos não foram lidos. Confira antes de salvar.',
        OcrStatus.failure =>
          'Não conseguimos ler este comprovante. Preencha manualmente.',
        OcrStatus.success => null,
      };
    });
    if (result.cnpj != null) _tryAutoCategory(result.cnpj);
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
        _ocrFilledFields.remove('data');
      });
    }
  }

  Future<void> _openCamera() async {
    final result = await context.push<OcrResult>('/camera');
    if (result != null && mounted) {
      _applyOcrResult(result);
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
      final isOcr =
          _ocrResult != null && _ocrResult!.status != OcrStatus.failure;

      if (widget.expenseId == null) {
        await service.createExpense(
          date: _selectedDate,
          category: _selectedCategory!,
          amountInCents: amountInCents,
          description: _descriptionController.text.trim(),
          beneficiario: _beneficiarioController.text.trim().nullIfEmpty,
          cnpj: _cnpj,
          origem: isOcr ? ExpenseOrigem.ocr : ExpenseOrigem.manual,
          imagePath: _ocrResult?.imagePath,
        );
      } else {
        await service.updateExpense(
          existing: _existingExpense!,
          date: _selectedDate,
          category: _selectedCategory!,
          amountInCents: amountInCents,
          description: _descriptionController.text.trim(),
          beneficiario: _beneficiarioController.text.trim().nullIfEmpty,
          cnpj: _cnpj,
        );
      }

      // Persist the user's CNPJ→category preference (Spec 3.3).
      if (_cnpj != null && _cnpj!.isNotEmpty) {
        await ref
            .read(cnpjCategorizationServiceProvider)
            .savePreference(_cnpj!, _selectedCategory!);
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
                    // OCR button (only for new expenses)
                    if (widget.expenseId == null) ...[
                      OutlinedButton.icon(
                        onPressed: _openCamera,
                        icon: const Icon(Icons.document_scanner_outlined),
                        label: const Text('Fotografar nota'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    // OCR message banner
                    if (_ocrMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _ocrMessage!,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],

                    // Valor
                    TextFormField(
                      key: const Key('amountField'),
                      controller: _amountController,
                      autofocus: widget.expenseId != null,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9,.]')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Valor',
                        prefixText: r'R$ ',
                        hintText: '0,00',
                        suffixIcon: _ocrFilledFields.contains('valor')
                            ? const _OcrBadge()
                            : null,
                      ),
                      onChanged: (_) =>
                          setState(() => _ocrFilledFields.remove('valor')),
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
                      onChanged: (v) => setState(() {
                        _selectedCategory = v;
                        _categorySuggested = false;
                      }),
                      validator: (v) =>
                          v == null ? 'Selecione uma categoria' : null,
                    ),
                    if (_categorySuggested) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Categoria sugerida',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),

                    // Data
                    TextFormField(
                      controller: _dateDisplayController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Data',
                        suffixIcon: _ocrFilledFields.contains('data')
                            ? const _OcrBadge()
                            : const Icon(Icons.calendar_today_outlined),
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
                      decoration: InputDecoration(
                        labelText: 'Beneficiário (opcional)',
                        hintText: 'Ex: Clínica São Lucas',
                        suffixIcon: _ocrFilledFields.contains('beneficiario')
                            ? const _OcrBadge()
                            : null,
                      ),
                      onChanged: (_) => setState(
                        () => _ocrFilledFields.remove('beneficiario'),
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

/// Small badge shown on fields that were pre-filled by OCR.
class _OcrBadge extends StatelessWidget {
  const _OcrBadge();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Preenchido pelo OCR',
      child: Icon(
        Icons.auto_awesome,
        size: 18,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
