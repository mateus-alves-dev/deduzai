import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/filter_favorites_table.dart';
import 'package:drift/drift.dart';

part 'filter_favorite_dao.g.dart';

@DriftAccessor(tables: [FilterFavorites])
class FilterFavoriteDao extends DatabaseAccessor<AppDatabase>
    with _$FilterFavoriteDaoMixin {
  FilterFavoriteDao(super.db);

  Stream<List<FilterFavorite>> watchAll() =>
      (select(filterFavorites)
            ..orderBy([(f) => OrderingTerm.desc(f.criadoEm)]))
          .watch();

  Future<int> count() =>
      (selectOnly(filterFavorites)
            ..addColumns([filterFavorites.id.count()]))
          .map((row) => row.read(filterFavorites.id.count()) ?? 0)
          .getSingle();

  Future<void> insert(FilterFavoritesCompanion entry) =>
      into(filterFavorites).insert(entry);

  Future<void> softDelete(String id) =>
      (delete(filterFavorites)..where((f) => f.id.equals(id))).go();

  Future<void> updateName(String id, String nome) =>
      (update(filterFavorites)..where((f) => f.id.equals(id))).write(
        FilterFavoritesCompanion(
          nome: Value(nome),
          atualizadoEm: Value(DateTime.now()),
        ),
      );
}
