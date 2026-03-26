import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/dependents_table.dart';
import 'package:drift/drift.dart';

part 'dependents_dao.g.dart';

@DriftAccessor(tables: [Dependents])
class DependentsDao extends DatabaseAccessor<AppDatabase>
    with _$DependentsDaoMixin {
  DependentsDao(super.db);

  Stream<List<Dependent>> watchAll() =>
      (select(dependents)
            ..where((d) => d.deletedAt.isNull())
            ..orderBy([(d) => OrderingTerm.asc(d.name)]))
          .watch();

  Future<List<Dependent>> getAll() =>
      (select(dependents)..where((d) => d.deletedAt.isNull())).get();

  Stream<int> watchActiveCount() {
    final countExpr = dependents.id.count();
    return (selectOnly(dependents)
          ..where(dependents.deletedAt.isNull())
          ..addColumns([countExpr]))
        .map((row) => row.read(countExpr) ?? 0)
        .watchSingle();
  }

  Future<int> getActiveCount() async {
    final countExpr = dependents.id.count();
    return (selectOnly(dependents)
          ..where(dependents.deletedAt.isNull())
          ..addColumns([countExpr]))
        .map((row) => row.read(countExpr) ?? 0)
        .getSingle();
  }

  Future<void> insertDependent(DependentsCompanion entry) =>
      into(dependents).insert(entry);

  Future<bool> updateDependent(DependentsCompanion entry) =>
      update(dependents).replace(entry);

  Future<void> softDelete(String id) =>
      (update(dependents)..where((d) => d.id.equals(id))).write(
        DependentsCompanion(
          deletedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<Dependent?> getById(String id) =>
      (select(dependents)
            ..where((d) => d.id.equals(id))
            ..where((d) => d.deletedAt.isNull()))
          .getSingleOrNull();
}
