import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/providers/future_provider.dart';

final FutureProviderFamily<Expense?, String?> expenseFormProvider =
    FutureProvider.family<Expense?, String?>((ref, expenseId) async {
      if (expenseId == null) return null;
      return ref.watch(expenseDaoProvider).watchById(expenseId).first;
    });
