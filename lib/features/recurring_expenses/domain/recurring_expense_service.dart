import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/database/daos/recurring_expense_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:deduzai/features/expense_entry/domain/expense_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'recurring_expense_service.g.dart';

@riverpod
RecurringExpenseService recurringExpenseService(Ref ref) =>
    RecurringExpenseService(
      ref.watch(recurringExpenseDaoProvider),
      ref.watch(expenseServiceProvider),
    );

class RecurringExpenseService {
  RecurringExpenseService(this._dao, this._expenseService);

  final RecurringExpenseDao _dao;
  final ExpenseService _expenseService;
  static const _uuid = Uuid();

  /// Computes the next due date strictly after [from].
  static DateTime computeNextDueDate({
    required RecurrenceFrequency frequency,
    required DateTime referenceDate,
    required DateTime from,
    int? dayOfMonth,
  }) {
    switch (frequency) {
      case RecurrenceFrequency.semanal:
        return from.add(const Duration(days: 7));

      case RecurrenceFrequency.quinzenal:
        // Walk forward from referenceDate in 14-day steps until past [from]
        var candidate = DateTime(
          referenceDate.year,
          referenceDate.month,
          referenceDate.day,
        );
        while (!candidate.isAfter(from)) {
          candidate = candidate.add(const Duration(days: 14));
        }
        return candidate;

      case RecurrenceFrequency.mensal:
        final day = dayOfMonth ?? referenceDate.day;
        var year = from.year;
        var month = from.month;
        // Try current month first, then advance
        for (var i = 0; i < 13; i++) {
          final lastDay = DateTime(year, month + 1, 0).day;
          final candidate = DateTime(year, month, day.clamp(1, lastDay));
          if (candidate.isAfter(from)) return candidate;
          month++;
          if (month > 12) {
            month = 1;
            year++;
          }
        }
        // Fallback (should never reach here)
        return DateTime(from.year, from.month + 1, day.clamp(1, 28));

      case RecurrenceFrequency.anual:
        final month = referenceDate.month;
        final day = referenceDate.day;
        var year = from.year;
        for (var i = 0; i < 3; i++) {
          final lastDay = DateTime(year, month + 1, 0).day;
          final candidate = DateTime(year, month, day.clamp(1, lastDay));
          if (candidate.isAfter(from)) return candidate;
          year++;
        }
        return DateTime(from.year + 1, month, day);
    }
  }

  Future<String> createTemplate({
    required String description,
    required int amountInCents,
    required DeductionCategory category,
    required RecurrenceFrequency frequency,
    required DateTime referenceDate,
    int? dayOfMonth,
    String? beneficiario,
    String? cnpj,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    // nextDueDate starts at referenceDate so it's immediately due if in the past
    await _dao.insertRecurringExpense(
      db.RecurringExpensesCompanion.insert(
        id: id,
        description: description,
        amountInCents: amountInCents,
        category: category.name,
        frequency: frequency.value,
        referenceDate: referenceDate,
        nextDueDate: referenceDate,
        dayOfMonth: Value(dayOfMonth),
        beneficiario: Value(beneficiario),
        cnpj: Value(cnpj),
        createdAt: now,
      ),
    );
    return id;
  }

  Future<void> updateTemplate({
    required db.RecurringExpense existing,
    required String description,
    required int amountInCents,
    required DeductionCategory category,
    required RecurrenceFrequency frequency,
    required DateTime referenceDate,
    required bool isActive,
    int? dayOfMonth,
    String? beneficiario,
    String? cnpj,
  }) async {
    await _dao.updateRecurringExpense(
      db.RecurringExpensesCompanion(
        id: Value(existing.id),
        description: Value(description),
        amountInCents: Value(amountInCents),
        category: Value(category.name),
        frequency: Value(frequency.value),
        referenceDate: Value(referenceDate),
        nextDueDate: Value(existing.nextDueDate),
        dayOfMonth: Value(dayOfMonth),
        beneficiario: Value(beneficiario),
        cnpj: Value(cnpj),
        isActive: Value(isActive),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        deletedAt: const Value(null),
      ),
    );
  }

  /// Register ONE occurrence of [template] for [forDate] and advance nextDueDate.
  Future<void> registerOccurrence(
    db.RecurringExpense template, {
    required DateTime forDate,
  }) async {
    await _expenseService.createExpense(
      date: forDate,
      category: DeductionCategory.values.byName(template.category),
      amountInCents: template.amountInCents,
      description: template.description,
      beneficiario: template.beneficiario,
      cnpj: template.cnpj,
      origem: ExpenseOrigem.recorrente,
    );

    final next = computeNextDueDate(
      frequency: RecurrenceFrequency.fromValue(template.frequency),
      referenceDate: template.referenceDate,
      from: forDate,
      dayOfMonth: template.dayOfMonth,
    );
    await _dao.updateNextDueDate(template.id, next);
  }

  /// Register ALL pending (overdue) occurrences for [template].
  /// Returns the number of expenses created.
  Future<int> registerAllPending(db.RecurringExpense template) async {
    final today = _today();
    var count = 0;
    var current = template;

    while (!current.nextDueDate.isAfter(today)) {
      await registerOccurrence(current, forDate: current.nextDueDate);
      count++;

      if (count >= 36) break; // safety cap: ~3 years of monthly

      final updated = await _dao.getById(template.id);
      if (updated == null) break;
      current = updated;
    }
    return count;
  }

  /// Bulk-register all due templates. Returns total expenses created.
  Future<int> registerAllDueNow() async {
    final due = await _dao.watchDue(_today()).first;
    var total = 0;
    for (final template in due) {
      total += await registerAllPending(template);
    }
    return total;
  }

  Future<void> deactivateTemplate(String id) =>
      _dao.setActive(id, active: false);

  Future<void> activateTemplate(String id) => _dao.setActive(id, active: true);

  Future<void> deleteTemplate(String id) => _dao.softDelete(id);

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }
}
