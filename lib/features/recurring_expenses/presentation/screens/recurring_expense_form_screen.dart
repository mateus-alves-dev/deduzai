import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
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

class RecurringExpenseFormScreen extends ConsumerStatefulWidget {
  const RecurringExpenseFormScreen({super.key, this.recurringId});

  final String? recurringId;

  @override
  ConsumerState<RecurringExpenseFormScreen> createState() =>
      _RecurringExpenseFormScreenState();
}

class _RecurringExpenseFormScreenState
    extends ConsumerState<RecurringExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _beneficiarioController;
  late final TextEditingController _dayController;

  DeductionCategory? _selectedCategory;
  RecurrenceFrequency _frequency = RecurrenceFrequency.mensal;
  DateTime _referenceDate = DateTime.now();
  bool _isActive = true;
  bool _isSaving = false;
  bool _showCategoryError = false;
  bool _initialized = false;
  db.RecurringExpense? _existing;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _beneficiarioController = TextEditingController();
    _dayController = TextEditingController(
      text: DateTime.now().day.toString(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized && widget.recurringId != null) {
      _initialized = true;
      _loadExisting();
    } else if (!_initialized) {
      _initialized = true;
    }
  }

  Future<void> _loadExisting() async {
    final dao = ref.read(recurringExpenseDaoProvider);
    final existing = await dao.getById(widget.recurringId!);
    if (existing == null || !mounted) return;

    final amount = existing.amountInCents / 100;
    setState(() {
      _existing = existing;
      _amountController.text = NumberFormat('#,##0.00', 'pt_BR').format(amount);
      _descriptionController.text = existing.description;
      _beneficiarioController.text = existing.beneficiario ?? '';
      _selectedCategory = DeductionCategory.values.byName(existing.category);
      _frequency = RecurrenceFrequency.fromValue(existing.frequency);
      _referenceDate = existing.referenceDate;
      _isActive = existing.isActive;
      _dayController.text =
          existing.dayOfMonth?.toString() ??
          existing.referenceDate.day.toString();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _beneficiarioController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  int? get _parsedAmountCents {
    final raw = _amountController.text.replaceAll('.', '').replaceAll(',', '.');
    final parsed = double.tryParse(raw);
    if (parsed == null) return null;
    return (parsed * 100).round();
  }

  bool get _isAnnual => _frequency == RecurrenceFrequency.anual;
  bool get _hasDayField =>
      _frequency == RecurrenceFrequency.mensal ||
      _frequency == RecurrenceFrequency.quinzenal;

  Future<void> _pickReferenceDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _referenceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _referenceDate = picked;
      });
    }
  }

  Future<void> _save() async {
    final amountCents = _parsedAmountCents;
    if (amountCents == null || amountCents <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um valor válido')),
      );
      return;
    }
    if (_selectedCategory == null) {
      setState(() => _showCategoryError = true);
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);

    final description = _descriptionController.text.trim();
    final beneficiario = _beneficiarioController.text.trim().nullIfEmpty;
    final dayOfMonth = _hasDayField
        ? int.tryParse(_dayController.text.trim())
        : _isAnnual
        ? _referenceDate.day
        : null;

    final service = ref.read(recurringExpenseServiceProvider);

    try {
      if (_existing != null) {
        await service.updateTemplate(
          existing: _existing!,
          description: description,
          amountInCents: amountCents,
          category: _selectedCategory!,
          frequency: _frequency,
          referenceDate: _referenceDate,
          dayOfMonth: dayOfMonth,
          beneficiario: beneficiario,
          cnpj: _existing!.cnpj,
          isActive: _isActive,
        );
      } else {
        await service.createTemplate(
          description: description,
          amountInCents: amountCents,
          category: _selectedCategory!,
          frequency: _frequency,
          referenceDate: _referenceDate,
          dayOfMonth: dayOfMonth,
          beneficiario: beneficiario,
        );
      }

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _existing != null
                  ? 'Recorrência atualizada ✓'
                  : 'Recorrência criada ✓',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.recurringId != null;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: DeduzaiAppBar(
        title: isEditing ? 'Editar recorrência' : 'Nova recorrência',
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Salvar'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Hero amount field
            _buildAmountField(theme),
            const SizedBox(height: AppSpacing.md),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Ex: Plano de Saúde, Mensalidade escola...',
                border: OutlineInputBorder(),
              ),
              maxLength: 255,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Informe uma descrição'
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),

            // Category
            CategorySelector(
              selected: _selectedCategory,
              onChanged: (cat) => setState(() {
                _selectedCategory = cat;
                _showCategoryError = false;
              }),
              showError: _showCategoryError,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Frequency
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
              selected: {_frequency},
              onSelectionChanged: (s) => setState(() => _frequency = s.first),
            ),
            const SizedBox(height: AppSpacing.md),

            // Day of month (mensal/quinzenal) or reference date (anual)
            if (_isAnnual) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Data de referência'),
                subtitle: Text(
                  '${DateFormat('dd/MM', 'pt_BR').format(_referenceDate)} (dia e mês para vencimento anual)',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickReferenceDate,
              ),
            ] else if (_hasDayField) ...[
              TextFormField(
                controller: _dayController,
                decoration: const InputDecoration(
                  labelText: 'Dia do mês',
                  hintText: '1–28',
                  border: OutlineInputBorder(),
                  helperText: 'Dia do mês em que o gasto vence',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 1 || n > 28) {
                    return 'Informe um dia entre 1 e 28';
                  }
                  return null;
                },
              ),
            ],
            const SizedBox(height: AppSpacing.md),

            // Beneficiário
            TextFormField(
              controller: _beneficiarioController,
              decoration: const InputDecoration(
                labelText: 'Beneficiário (opcional)',
                border: OutlineInputBorder(),
              ),
              maxLength: 255,
            ),
            const SizedBox(height: AppSpacing.md),

            // Active toggle (edit only)
            if (isEditing) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Recorrência ativa'),
                subtitle: Text(
                  _isActive
                      ? 'Aparecerá quando vencer'
                      : 'Pausada — não gera notificações',
                ),
                value: _isActive,
                onChanged: (v) => setState(() => _isActive = v),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
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
                style: AppTextStyles.titleLarge.copyWith(
                  color: theme.colorScheme.primary,
                  fontSize: 24,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0,00',
                    hintStyle: TextStyle(fontSize: 40),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
