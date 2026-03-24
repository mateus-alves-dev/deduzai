import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
abstract class Expense with _$Expense {
  const factory Expense({
    required String id,
    required DateTime date,
    required DeductionCategory category,
    required int amountInCents,
    required String description,
    required DateTime createdAt,
    required ExpenseOrigem origem,
    String? receiptPath,
    String? beneficiario,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
