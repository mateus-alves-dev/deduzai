import 'package:deduzai/core/database/tables/expenses_table.dart';
import 'package:drift/drift.dart';

class Receipts extends Table {
  TextColumn get id => text()();
  TextColumn get expenseId => text().references(Expenses, #id)();
  TextColumn get localPath => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
