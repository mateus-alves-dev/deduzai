import 'package:deduzai/core/domain/models/category.dart';

/// Deduction ceilings per category, per fiscal year.
///
/// Values are in centavos. A null value means the category is unlimited.
/// Per RN-05: ceilings must not be hardcoded in business logic — they live here
/// and can be updated independently as Receita Federal revises them.
class DeductionCaps {
  const DeductionCaps._();

  static const Map<int, Map<DeductionCategory, int?>> _capsByYear = {
    2023: {
      DeductionCategory.educacao: 350000, // R$ 3.500,00
    },
    2024: {
      DeductionCategory.educacao: 350000, // R$ 3.500,00
    },
    2025: {
      DeductionCategory.educacao: 356150, // R$ 3.561,50
    },
    2026: {
      // R$ 3.561,50 — placeholder until RF publishes official value
      DeductionCategory.educacao: 356150,
    },
  };

  /// Returns a map of category → cap in centavos for [year].
  /// Categories absent from the map (or with null value) are unlimited.
  static Map<DeductionCategory, int?> forYear(int year) {
    return _capsByYear[year] ?? {};
  }

  /// Returns the cap in centavos for a specific [category] and [year],
  /// or null if there is no ceiling.
  static int? capFor(DeductionCategory category, int year) {
    return _capsByYear[year]?[category];
  }
}
