import 'package:deduzai/core/domain/models/refund_simulation.dart';
import 'package:deduzai/core/domain/models/tax_brackets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refund_simulation_service.g.dart';

@riverpod
RefundSimulationService refundSimulationService(Ref ref) =>
    const RefundSimulationService();

/// Computes the estimated income tax refund based on gross income and deductions.
class RefundSimulationService {
  const RefundSimulationService();

  /// Simulates the refund for a given [grossIncomeInCents], [totalDeductibleInCents],
  /// and [fiscalYear].
  ///
  /// The estimation assumes the user's employer withheld tax on the full gross income
  /// (without deductions). The refund is the difference between tax paid on gross income
  /// and tax actually owed after deductions.
  RefundSimulation simulate({
    required int grossIncomeInCents,
    required int totalDeductibleInCents,
    required int fiscalYear,
  }) {
    // Taxable base cannot go below zero
    final taxableBase =
        (grossIncomeInCents - totalDeductibleInCents).clamp(0, grossIncomeInCents);

    final taxWithout =
        TaxBrackets.computeTaxInCents(grossIncomeInCents, fiscalYear);
    final taxWith = TaxBrackets.computeTaxInCents(taxableBase, fiscalYear);

    final refund = taxWithout - taxWith;

    // Effective rate: tax with deductions / gross income
    final effectiveRate = grossIncomeInCents > 0
        ? (taxWith / grossIncomeInCents) * 100
        : 0.0;

    return RefundSimulation(
      grossIncomeInCents: grossIncomeInCents,
      totalDeductibleInCents: totalDeductibleInCents,
      taxableBaseInCents: taxableBase,
      taxWithoutDeductionsInCents: taxWithout,
      taxWithDeductionsInCents: taxWith,
      estimatedRefundInCents: refund,
      effectiveRatePercent: double.parse(effectiveRate.toStringAsFixed(2)),
    );
  }
}
