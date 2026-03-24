import 'dart:io';

import 'package:deduzai/core/database/app_database.dart' as db;
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/daos/receipt_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/core/domain/models/expense_origem.dart';
import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'expense_service.g.dart';

@riverpod
ExpenseService expenseService(Ref ref) => ExpenseService(
      ref.watch(expenseDaoProvider),
      ref.watch(receiptDaoProvider),
    );

class ExpenseService {
  ExpenseService(this._dao, this._receiptDao);

  final ExpenseDao _dao;
  final ReceiptDao _receiptDao;
  static const _uuid = Uuid();

  Future<void> createExpense({
    required DateTime date,
    required DeductionCategory category,
    required int amountInCents,
    required String description,
    String? beneficiario,
    String? cnpj,
    ExpenseOrigem origem = ExpenseOrigem.manual,
    String? imagePath,
  }) async {
    final now = DateTime.now();
    final expenseId = _uuid.v4();

    await _dao.insertExpense(
      db.ExpensesCompanion.insert(
        id: expenseId,
        date: date,
        category: category.name,
        amountInCents: amountInCents,
        description: description,
        origem: Value(origem.value),
        beneficiario: Value(beneficiario),
        cnpj: Value(cnpj),
        createdAt: now,
      ),
    );

    if (imagePath != null) {
      final file = File(imagePath);
      final size = await file.length();
      await _receiptDao.insertReceipt(
        db.ReceiptsCompanion.insert(
          id: _uuid.v4(),
          expenseId: expenseId,
          localPath: imagePath,
          mimeType: const Value('image/jpeg'),
          tamanhoBytes: Value(size),
          ocrStatus: Value(
            origem == ExpenseOrigem.ocr
                ? OcrStatus.success.name
                : OcrStatus.failure.name,
          ),
          createdAt: now,
        ),
      );
    }
  }

  Future<void> updateExpense({
    required db.Expense existing,
    required DateTime date,
    required DeductionCategory category,
    required int amountInCents,
    required String description,
    String? beneficiario,
    String? cnpj,
  }) async {
    await _dao.updateExpense(
      db.ExpensesCompanion(
        id: Value(existing.id),
        date: Value(date),
        category: Value(category.name),
        amountInCents: Value(amountInCents),
        description: Value(description),
        beneficiario: Value(beneficiario),
        cnpj: Value(cnpj),
        receiptPath: Value(existing.receiptPath),
        origem: Value(existing.origem),
        createdAt: Value(existing.createdAt),
        updatedAt: Value(DateTime.now()),
        deletedAt: const Value(null),
      ),
    );
  }

  Future<void> deleteExpense(String id) => _dao.softDelete(id);

  /// Attaches a new receipt to an existing expense (Spec 4.3).
  Future<void> attachReceipt({
    required String expenseId,
    required String imagePath,
    required OcrStatus ocrStatus,
  }) async {
    final file = File(imagePath);
    final size = await file.length();
    await _receiptDao.insertReceipt(
      db.ReceiptsCompanion.insert(
        id: _uuid.v4(),
        expenseId: expenseId,
        localPath: imagePath,
        mimeType: const Value('image/jpeg'),
        tamanhoBytes: Value(size),
        ocrStatus: Value(ocrStatus.name),
        createdAt: DateTime.now(),
      ),
    );
  }
}
