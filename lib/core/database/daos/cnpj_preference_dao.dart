import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/cnpj_preferences_table.dart';
import 'package:drift/drift.dart';

part 'cnpj_preference_dao.g.dart';

@DriftAccessor(tables: [CnpjPreferences])
class CnpjPreferenceDao extends DatabaseAccessor<AppDatabase>
    with _$CnpjPreferenceDaoMixin {
  CnpjPreferenceDao(super.db);

  Future<CnpjPreference?> getByKey(String cnpj) => (select(
    cnpjPreferences,
  )..where((r) => r.cnpj.equals(cnpj))).getSingleOrNull();

  Future<void> upsert(
    String cnpj,
    String category, {
    String? beneficiario,
    String? cnaeDescricao,
  }) => into(cnpjPreferences).insertOnConflictUpdate(
    CnpjPreferencesCompanion.insert(
      cnpj: cnpj,
      category: category,
      beneficiario: Value(beneficiario),
      cnaeDescricao: Value(cnaeDescricao),
      updatedAt: DateTime.now(),
    ),
  );
}
