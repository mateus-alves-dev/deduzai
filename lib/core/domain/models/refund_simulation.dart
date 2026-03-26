import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_simulation.freezed.dart';

/// Result of the income tax refund simulation.
///
/// All monetary values are in centavos (int).
@freezed
abstract class RefundSimulation with _$RefundSimulation {
  const factory RefundSimulation({
    /// Gross annual income declared by the user (centavos).
    required int grossIncomeInCents,

    /// Total deductible amount from registered expenses (centavos).
    required int totalDeductibleInCents,

    /// Taxable base = gross income - total deductible (centavos).
    required int taxableBaseInCents,

    /// Income tax calculated on gross income without any deductions (centavos).
    required int taxWithoutDeductionsInCents,

    /// Income tax calculated on taxable base (with deductions applied) (centavos).
    required int taxWithDeductionsInCents,

    /// Estimated refund = tax without deductions - tax with deductions (centavos).
    /// Positive means the user gets money back. Negative means extra tax to pay.
    required int estimatedRefundInCents,

    /// Effective tax rate after deductions, as a percentage (e.g. 15.3).
    required double effectiveRatePercent,
  }) = _RefundSimulation;
}
