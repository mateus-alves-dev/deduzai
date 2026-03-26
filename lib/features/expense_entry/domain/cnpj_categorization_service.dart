import 'package:deduzai/core/database/daos/cnpj_preference_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/features/expense_entry/data/cnpj_api_service.dart';
import 'package:deduzai/features/expense_entry/domain/cnae_category_mapper.dart';
import 'package:deduzai/features/expense_entry/domain/cnpj_lookup_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cnpj_categorization_service.g.dart';

@riverpod
CnpjCategorizationService cnpjCategorizationService(Ref ref) =>
    CnpjCategorizationService(
      ref.watch(cnpjPreferenceDaoProvider),
      ref.watch(cnpjApiServiceProvider),
    );

class CnpjCategorizationService {
  CnpjCategorizationService(this._dao, this._apiService);

  final CnpjPreferenceDao _dao;
  final CnpjApiService _apiService;

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

  /// Performs a comprehensive CNPJ lookup with local cache + API enrichment.
  ///
  /// Flow:
  /// 1. Check local preference cache
  /// 2. If not cached, fetch from BrasilAPI
  /// 3. Map CNAE fiscal code to category suggestion via [CnaeCategoryMapper]
  /// 4. Extract beneficiário (nome_fantasia ?? razao_social)
  /// 5. Cache result locally
  /// 6. Return [CnpjLookupResult] with all suggestions
  ///
  /// This method is silent-by-default: if API is unavailable, it returns
  /// cached data (if any) or an empty result. No errors are thrown.
  Future<CnpjLookupResult> lookup(String cnpj) async {
    // 1. Check local cache first
    final cached = await _dao.getByKey(cnpj);
    if (cached != null) {
      final category = DeductionCategory.values.byName(cached.category);
      return CnpjLookupResult(
        suggestedCategory: category,
        beneficiario: cached.beneficiario,
        cnaeDescricao: cached.cnaeDescricao,
        isValid: true,
      );
    }

    // 2. Fetch from BrasilAPI (silent fallback if fails)
    final apiResult = await _apiService.fetchCnpj(cnpj);
    if (apiResult == null) {
      return const CnpjLookupResult();
    }

    // 3. Map CNAE to category
    final suggestedCategory = CnaeCategoryMapper.categoryFromCnae(
      apiResult.cnaeFiscal,
    );

    // 4. Extract beneficiário
    final beneficiario = apiResult.nomeFantasia ?? apiResult.razaoSocial;

    // 5. Cache the result
    await _dao.upsert(
      cnpj,
      suggestedCategory?.name ?? DeductionCategory.saude.name,
      beneficiario: beneficiario,
      cnaeDescricao: apiResult.cnaeFiscalDescricao,
    );

    // 6. Return suggestions
    return CnpjLookupResult(
      suggestedCategory: suggestedCategory,
      beneficiario: beneficiario,
      cnaeDescricao: apiResult.cnaeFiscalDescricao,
      isValid: true,
    );
  }
}
