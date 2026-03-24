import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expense_form_provider.g.dart';

@riverpod
Future<Expense?> expenseForm(Ref ref, String? expenseId) async {
  if (expenseId == null) return null;
  return ref.watch(expenseDaoProvider).watchById(expenseId).first;
}
