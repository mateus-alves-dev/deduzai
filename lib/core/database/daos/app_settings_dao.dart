import 'package:deduzai/core/database/app_database.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:drift/drift.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<String?> getValue(String key) async {
    final row = await (select(appSettings)
          ..where((r) => r.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setValue(String key, String value) =>
      into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion.insert(key: key, value: value),
      );
}
