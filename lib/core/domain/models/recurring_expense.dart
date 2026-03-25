import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/recurrence_frequency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_expense.freezed.dart';
part 'recurring_expense.g.dart';

@freezed
abstract class RecurringExpense with _$RecurringExpense {
  const factory RecurringExpense({
    required String id,
    required String description,
    required int amountInCents,
    required DeductionCategory category,
    required RecurrenceFrequency frequency,
    required DateTime referenceDate,
    required DateTime nextDueDate,
    required bool isActive,
    required DateTime createdAt,
    int? dayOfMonth,
    String? beneficiario,
    String? cnpj,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _RecurringExpense;

  factory RecurringExpense.fromJson(Map<String, dynamic> json) =>
      _$RecurringExpenseFromJson(json);
}
