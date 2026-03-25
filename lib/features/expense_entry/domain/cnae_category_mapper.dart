import 'package:deduzai/core/domain/models/category.dart';

/// Maps CNAE fiscal codes to deduction categories based on economic activity.
///
/// Uses the first 2 digits (CNAE division) for broad classification:
/// - 86 (health services) → Saúde
/// - 85 (education) → Educação
/// - 65-66 (insurance/pension/financial) → Previdência Privada
/// - Otherwise → null (no suggestion)
class CnaeCategoryMapper {
  /// Returns a suggested [DeductionCategory] based on the CNAE fiscal code,
  /// or null if no mapping is available.
  static DeductionCategory? categoryFromCnae(int cnaeFiscal) {
    final division = (cnaeFiscal ~/ 100) % 100; // Extract first 2 digits

    return switch (division) {
      86 => DeductionCategory.saude,
      85 => DeductionCategory.educacao,
      65 || 66 => DeductionCategory.previdenciaPrivada,
      _ => null,
    };
  }
}
