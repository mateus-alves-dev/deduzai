import 'package:drift/drift.dart';

class RecurringExpenses extends Table {
  TextColumn get id => text()();
  TextColumn get description => text()();
  IntColumn get amountInCents => integer()();
  TextColumn get category => text()();
  TextColumn get frequency => text()();
  IntColumn get dayOfMonth => integer().nullable()();
  DateTimeColumn get referenceDate => dateTime()();
  DateTimeColumn get nextDueDate => dateTime()();
  TextColumn get beneficiario => text().nullable()();
  TextColumn get cnpj => text().nullable()();
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
