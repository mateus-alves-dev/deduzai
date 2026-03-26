import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the gross annual income in centavos for a given fiscal year.
///
/// Returns `null` if the user hasn't set their income yet.
final grossAnnualIncomeProvider =
    FutureProvider.family<int?, int>((ref, year) async {
  final dao = ref.watch(appSettingsDaoProvider);
  final key = AppSettingsKeys.grossAnnualIncome(year);
  final raw = await dao.getValue(key);
  if (raw == null || raw.isEmpty) return null;
  return int.tryParse(raw);
});

/// Writes or clears the gross annual income for a given fiscal year.
///
/// After writing, invalidates [grossAnnualIncomeProvider] so readers refresh.
final grossIncomeUpdaterProvider =
    Provider.family<GrossIncomeUpdater, int>((ref, year) {
  return GrossIncomeUpdater(ref, year);
});

class GrossIncomeUpdater {
  GrossIncomeUpdater(this._ref, this._year);

  final Ref _ref;
  final int _year;

  Future<void> update(int? incomeInCents) async {
    final dao = _ref.read(appSettingsDaoProvider);
    final key = AppSettingsKeys.grossAnnualIncome(_year);
    if (incomeInCents == null) {
      await dao.setValue(key, '');
    } else {
      await dao.setValue(key, incomeInCents.toString());
    }
    _ref.invalidate(grossAnnualIncomeProvider(_year));
  }
}
