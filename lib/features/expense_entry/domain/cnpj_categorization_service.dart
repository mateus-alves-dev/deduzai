import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cnpj_categorization_service.g.dart';

@riverpod
CnpjCategorizationService cnpjCategorizationService(Ref ref) =>
    CnpjCategorizationService(ref.watch(cnpjPreferenceDaoProvider));

class CnpjCategorizationService {
  CnpjCategorizationService(this._dao);

  final CnpjPreferenceDao _dao;

  /// Returns the user's saved category preference for [cnpj], or null if
  /// the CNPJ has never been seen before (Spec 3.2).
  Future<DeductionCategory?> suggestCategory(String cnpj) async {
    final pref = await _dao.getByKey(cnpj);
    if (pref == null) return null;
    return DeductionCategory.values.byName(pref.category);
  }

  /// Persists (or updates) the user's category preference for [cnpj] (Spec 3.3).
  Future<void> savePreference(String cnpj, DeductionCategory category) =>
      _dao.upsert(cnpj, category.name);
}
