import 'package:drift/drift.dart';

class Expenses extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get category => text()();
  IntColumn get amountInCents => integer()();
  TextColumn get description => text()();
  TextColumn get receiptPath => text().nullable()();
  TextColumn get beneficiario => text().nullable()();
  TextColumn get origem => text().withDefault(const Constant('MANUAL'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
