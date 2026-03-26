/// A single bracket in the progressive tax table.
class TaxBracket {
  const TaxBracket({
    required this.upperLimitInCents,
    required this.ratePercent,
    required this.deductionInCents,
  });

  /// Upper limit of this bracket in centavos.
  /// Use `null` for the last (unlimited) bracket.
  final int? upperLimitInCents;

  /// Tax rate as a percentage (e.g. 7.5 for 7.5%).
  final double ratePercent;

  /// Deduction amount for this bracket in centavos.
  final int deductionInCents;
}

/// Brazilian IRPF progressive tax brackets per fiscal year.
///
/// Values are in centavos. Percentages are expressed as doubles (e.g. 7.5).
/// Per Receita Federal tables — updated independently as rates change.
class TaxBrackets {
  const TaxBrackets._();

  static const List<TaxBracket> _brackets2023 = [
    TaxBracket(
      upperLimitInCents: 2499648,
      ratePercent: 0,
      deductionInCents: 0,
    ),
    TaxBracket(
      upperLimitInCents: 3326112,
      ratePercent: 7.5,
      deductionInCents: 187474,
    ),
    TaxBracket(
      upperLimitInCents: 4415880,
      ratePercent: 15,
      deductionInCents: 436580,
    ),
    TaxBracket(
      upperLimitInCents: 5499360,
      ratePercent: 22.5,
      deductionInCents: 768033,
    ),
    TaxBracket(
      upperLimitInCents: null,
      ratePercent: 27.5,
      deductionInCents: 1043450,
    ),
  ];

  static const List<TaxBracket> _brackets2024 = [
    TaxBracket(
      upperLimitInCents: 2696320,
      ratePercent: 0,
      deductionInCents: 0,
    ),
    TaxBracket(
      upperLimitInCents: 3391980,
      ratePercent: 7.5,
      deductionInCents: 202224,
    ),
    TaxBracket(
      upperLimitInCents: 4501260,
      ratePercent: 15,
      deductionInCents: 456623,
    ),
    TaxBracket(
      upperLimitInCents: 5597616,
      ratePercent: 22.5,
      deductionInCents: 794317,
    ),
    TaxBracket(
      upperLimitInCents: null,
      ratePercent: 27.5,
      deductionInCents: 1074098,
    ),
  ];

  static const Map<int, List<TaxBracket>> _bracketsByYear = {
    2023: _brackets2023,
    2024: _brackets2024,
    2025: _brackets2024, // same table as 2024
    2026: _brackets2024, // placeholder until RF publishes official value
  };

  /// Returns the progressive tax brackets for [year].
  ///
  /// Throws [ArgumentError] if [year] is not supported.
  static List<TaxBracket> forYear(int year) {
    final brackets = _bracketsByYear[year];
    if (brackets == null) {
      throw ArgumentError('No tax brackets available for year $year');
    }
    return brackets;
  }

  /// Computes the total income tax due (in centavos) for a given
  /// [taxableIncomeInCents] using the progressive table for [year].
  ///
  /// Returns 0 when [taxableIncomeInCents] ≤ 0.
  static int computeTaxInCents(int taxableIncomeInCents, int year) {
    if (taxableIncomeInCents <= 0) return 0;

    final brackets = forYear(year);

    // Find the bracket that contains taxableIncomeInCents.
    var applicable = brackets.last;
    for (final bracket in brackets) {
      if (bracket.upperLimitInCents != null &&
          taxableIncomeInCents <= bracket.upperLimitInCents!) {
        applicable = bracket;
        break;
      }
    }

    final raw =
        (taxableIncomeInCents * applicable.ratePercent / 100).round() -
        applicable.deductionInCents;

    return raw < 0 ? 0 : raw;
  }
}
