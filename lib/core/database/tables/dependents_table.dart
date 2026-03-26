import 'package:drift/drift.dart';

class Dependents extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get relationship => text()();
  DateTimeColumn get birthDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
