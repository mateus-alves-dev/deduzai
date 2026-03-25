import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/features/expense_entry/domain/cnpj_categorization_service.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:deduzai/features/expense_entry/presentation/providers/expense_form_provider.dart';
import 'package:deduzai/features/expense_entry/presentation/widgets/category_selector.dart';
import 'package:deduzai/features/recurring_expenses/domain/recurring_expense_service.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
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
  bool _showCategoryError = false;

  // OCR state
  OcrResult? _ocrResult;
  // Tracks which fields were prefilled by OCR
  final Set<String> _ocrFilledFields = {};
  String? _ocrMessage;
  String? _cnpj;

  // CNPJ auto-categorization state (F3)
  bool _categorySuggested = false;
  bool _beneficiarioAutoFilled = false;
  String? _cnaeDescricao;

  // Recurrence
  bool _isRecurring = false;
  RecurrenceFrequency _recurrenceFrequency = RecurrenceFrequency.mensal;
  late final TextEditingController _dayController;

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
    _dayController = TextEditingController(
      text: DateTime.now().day.toString(),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _beneficiarioController.dispose();
    _dateDisplayController.dispose();
    _dayController.dispose();
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
    // Attempt to lookup CNPJ for category + beneficiário suggestions
    if (expense.cnpj != null) _tryCnpjLookup(expense.cnpj);
  }

  Future<void> _tryCnpjLookup(String? cnpj) async {
    if (cnpj == null || cnpj.isEmpty) return;
    final service = ref.read(cnpjCategorizationServiceProvider);
    final result = await service.lookup(cnpj);
    if (!mounted) return;

    setState(() {
      // Auto-fill category if suggestion exists
      if (result.suggestedCategory != null) {
        _selectedCategory = result.suggestedCategory;
        _categorySuggested = true;
      }

      // Auto-fill beneficiário if provided AND field is empty
      if (result.beneficiario != null &&
          result.beneficiario!.isNotEmpty &&
          _beneficiarioController.text.isEmpty &&
          !_ocrFilledFields.contains('beneficiario')) {
        _beneficiarioController.text = result.beneficiario!;
        _beneficiarioAutoFilled = true;
      }

      if (result.cnaeDescricao != null) {
        _cnaeDescricao = result.cnaeDescricao;
      }
    });
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
    if (result.cnpj != null) _tryCnpjLookup(result.cnpj);
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
    final formValid = _formKey.currentState!.validate();
    final categoryValid = _selectedCategory != null;

    if (!categoryValid) {
      setState(() => _showCategoryError = true);
    }

    if (!formValid || !categoryValid || dateError != null) {
      if (dateError != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dateError)));
      }
      return;
    }

    if (_isRecurring && _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe uma descrição para o gasto recorrente'),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final rawAmount = _amountController.text
          .replaceAll('.', '')
          .replaceAll(',', '.');
      final amountInCents = (double.parse(rawAmount) * 100).round();

      if (_isRecurring) {
        final hasDayField =
            _recurrenceFrequency == RecurrenceFrequency.mensal ||
            _recurrenceFrequency == RecurrenceFrequency.quinzenal;
        final isAnnual = _recurrenceFrequency == RecurrenceFrequency.anual;
        final dayOfMonth = hasDayField
            ? int.tryParse(_dayController.text.trim())
            : isAnnual
            ? _selectedDate.day
            : null;

        final recurringService = ref.read(recurringExpenseServiceProvider);
        final id = await recurringService.createTemplate(
          description: _descriptionController.text.trim(),
          amountInCents: amountInCents,
          category: _selectedCategory!,
          frequency: _recurrenceFrequency,
          referenceDate: _selectedDate,
          dayOfMonth: dayOfMonth,
          beneficiario: _beneficiarioController.text.trim().nullIfEmpty,
          cnpj: _cnpj,
        );

        final template = await ref.read(recurringExpenseDaoProvider).getById(id);
        if (template != null) {
          await recurringService.registerOccurrence(
            template,
            forDate: _selectedDate,
          );
        }
      } else {
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
      }

      // Persist the user's CNPJ→category preference (Spec 3.3).
      if (_cnpj != null && _cnpj!.isNotEmpty) {
        await ref
            .read(cnpjCategorizationServiceProvider)
            .savePreference(_cnpj!, _selectedCategory!);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isRecurring ? 'Gasto recorrente criado ✓' : 'Gasto salvo ✓',
            ),
            duration: const Duration(seconds: 2),
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
        appBar: DeduzaiAppBar(
          title: widget.expenseId != null ? 'Editar Gasto' : 'Novo Gasto',
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: const DeduzaiAppBar(title: 'Erro'),
        body: Center(child: Text('Erro ao carregar gasto: $e')),
      ),
      data: (_) => _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: DeduzaiAppBar(
        title: widget.expenseId != null ? 'Editar Gasto' : 'Novo Gasto',
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
                    // OCR card (only for new expenses)
                    if (widget.expenseId == null) ...[
                      _buildOcrCard(theme),
                      const SizedBox(height: AppSpacing.sm),
                    ],

                    // OCR message banner
                    if (_ocrMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _ocrMessage!,
                                style: TextStyle(
                                  color:
                                      theme.colorScheme.onSecondaryContainer,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],

                    // Hero amount field
                    _buildHeroAmount(theme),

                    const Divider(height: AppSpacing.xl),

                    // Category chip selector
                    CategorySelector(
                      selected: _selectedCategory,
                      onChanged: (cat) => setState(() {
                        _selectedCategory = cat;
                        _categorySuggested = false;
                        _showCategoryError = false;
                      }),
                      showError: _showCategoryError,
                    ),
                    if (_categorySuggested) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Categoria sugerida',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
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
                        suffixIcon:
                            _ocrFilledFields.contains('beneficiario') ||
                                    _beneficiarioAutoFilled
                                ? const _OcrBadge()
                                : null,
                      ),
                      onChanged: (_) {
                        setState(() {
                          _ocrFilledFields.remove('beneficiario');
                          _beneficiarioAutoFilled = false;
                        });
                      },
                      maxLength: 255,
                    ),
                    if (_beneficiarioAutoFilled &&
                        !_ocrFilledFields.contains('beneficiario')) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Beneficiário preenchido automaticamente',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // CNPJ / CNAE info card
                    if (_cnpj != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      _CnpjInfoCard(
                        cnpj: _cnpj!,
                        cnaeDescricao: _cnaeDescricao,
                      ),
                    ],

                    // Recurrence toggle (new expenses only)
                    if (widget.expenseId == null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Gasto recorrente'),
                        subtitle: const Text(
                          'Repete automaticamente em datas futuras',
                        ),
                        value: _isRecurring,
                        onChanged: (v) => setState(() => _isRecurring = v),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: _isRecurring
                            ? _buildRecurrenceSection(theme)
                            : const SizedBox.shrink(),
                      ),
                    ],
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

  Widget _buildRecurrenceSection(ThemeData theme) {
    final hasDayField =
        _recurrenceFrequency == RecurrenceFrequency.mensal ||
        _recurrenceFrequency == RecurrenceFrequency.quinzenal;
    final isAnnual = _recurrenceFrequency == RecurrenceFrequency.anual;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Frequência',
          style: AppTextStyles.labelMedium.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<RecurrenceFrequency>(
          segments: RecurrenceFrequency.values
              .map(
                (f) => ButtonSegment<RecurrenceFrequency>(
                  value: f,
                  label: Text(f.label),
                ),
              )
              .toList(),
          selected: {_recurrenceFrequency},
          onSelectionChanged: (s) =>
              setState(() => _recurrenceFrequency = s.first),
        ),
        const SizedBox(height: AppSpacing.md),
        if (hasDayField)
          TextFormField(
            controller: _dayController,
            decoration: const InputDecoration(
              labelText: 'Dia do mês',
              hintText: '1–28',
              helperText: 'Dia do mês em que o gasto vence',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            validator: (_) {
              if (!_isRecurring || !hasDayField) return null;
              final n = int.tryParse(_dayController.text.trim());
              if (n == null || n < 1 || n > 28) {
                return 'Informe um dia entre 1 e 28';
              }
              return null;
            },
          )
        else if (isAnnual)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Mês de referência'),
            subtitle: Text(
              '${DateFormat('dd/MM', 'pt_BR').format(_selectedDate)} — vencimento anual nesta data',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickDate,
          ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _buildOcrCard(ThemeData theme) {
    return Card(
      color: theme.colorScheme.secondaryContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openCamera,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.document_scanner_outlined,
                  color: theme.colorScheme.onSecondaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fotografar nota fiscal',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      'Preencha automaticamente com OCR',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: theme.colorScheme.onSecondaryContainer
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroAmount(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'Valor',
            style: AppTextStyles.labelMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                r'R$ ',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              IntrinsicWidth(
                child: TextFormField(
                  key: const Key('amountField'),
                  controller: _amountController,
                  autofocus: widget.expenseId == null,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: theme.colorScheme.primary,
                    fontFeatures: [const FontFeature.tabularFigures()],
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9,.]')),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintText: '0,00',
                    hintStyle: AppTextStyles.headlineLarge.copyWith(
                      color: theme.colorScheme.outlineVariant,
                    ),
                    contentPadding: EdgeInsets.zero,
                    errorStyle: const TextStyle(fontSize: 12),
                  ),
                  onChanged: (_) =>
                      setState(() => _ocrFilledFields.remove('valor')),
                  validator: _validateAmount,
                ),
              ),
              if (_ocrFilledFields.contains('valor')) ...[
                const SizedBox(width: AppSpacing.xs),
                const _OcrBadge(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

String _formatCnpj(String raw) {
  final d = raw.replaceAll(RegExp(r'\D'), '');
  if (d.length != 14) return raw;
  return '${d.substring(0, 2)}.${d.substring(2, 5)}.${d.substring(5, 8)}/${d.substring(8, 12)}-${d.substring(12)}';
}

/// Read-only card showing CNPJ and CNAE info obtained from lookup.
class _CnpjInfoCard extends StatelessWidget {
  const _CnpjInfoCard({required this.cnpj, this.cnaeDescricao});

  final String cnpj;
  final String? cnaeDescricao;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.business_outlined,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatCnpj(cnpj),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (cnaeDescricao != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    cnaeDescricao!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
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
