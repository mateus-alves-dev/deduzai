import 'package:drift/drift.dart';

class FilterFavorites extends Table {
  TextColumn get id => text()();
  TextColumn get nome => text()();
  TextColumn get categorias => text().nullable()(); // JSON: ["saude","educacao"]
  DateTimeColumn get dataInicio => dateTime().nullable()();
  DateTimeColumn get dataFim => dateTime().nullable()();
  IntColumn get valorMin => integer().nullable()();
  IntColumn get valorMax => integer().nullable()();
  BoolColumn get comComprovante =>
      boolean().nullable()(); // null=todos, true=com, false=sem
  DateTimeColumn get criadoEm => dateTime()();
  DateTimeColumn get atualizadoEm => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
