import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:drift/drift.dart';

class Receipts extends Table {
  TextColumn get id => text()();
  TextColumn get expenseId => text().references(Expenses, #id)();
  TextColumn get localPath => text()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get tamanhoBytes => integer().nullable()();
  TextColumn get ocrStatus => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
