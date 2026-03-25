import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:deduzai/core/domain/models/category.dart';

part 'cnpj_lookup_result.freezed.dart';

/// Result of a CNPJ lookup operation.
///
/// Contains optional suggestions that may have been populated from:
/// - Local cache (user preferences)
/// - BrasilAPI response (CNAE-based category + beneficiário name)
/// - CNPJ validation result
@freezed
abstract class CnpjLookupResult with _$CnpjLookupResult {
  const factory CnpjLookupResult({
    DeductionCategory? suggestedCategory,
    String? beneficiario,
    bool? isValid,
    String? cnaeDescricao,
  }) = _CnpjLookupResult;
}
