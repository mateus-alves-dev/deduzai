import 'package:drift/drift.dart';

class CnpjPreferences extends Table {
  TextColumn get cnpj => text()();
  TextColumn get category => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {cnpj};
}
