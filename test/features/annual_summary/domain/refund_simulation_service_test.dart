import 'package:deduzai/features/annual_summary/domain/refund_simulation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = RefundSimulationService();
  const year = 2025;

  group('RefundSimulationService.simulate', () {
    test('basic simulation — high income with deductions', () {
      final result = service.simulate(
        grossIncomeInCents: 10000000,
        totalDeductibleInCents: 2000000,
        fiscalYear: year,
      );

      expect(result.taxableBaseInCents, 8000000);
      expect(result.taxWithoutDeductionsInCents, 1675902);
      expect(result.taxWithDeductionsInCents, 1125902);
      expect(result.estimatedRefundInCents, 550000);
      expect(result.effectiveRatePercent, 11.26);
    });

    test('zero income — all values are zero', () {
      final result = service.simulate(
        grossIncomeInCents: 0,
        totalDeductibleInCents: 500000,
        fiscalYear: year,
      );

      expect(result.taxableBaseInCents, 0);
      expect(result.taxWithoutDeductionsInCents, 0);
      expect(result.taxWithDeductionsInCents, 0);
      expect(result.estimatedRefundInCents, 0);
      expect(result.effectiveRatePercent, 0.0);
    });

    test('zero deductions — no refund', () {
      final result = service.simulate(
        grossIncomeInCents: 5000000,
        totalDeductibleInCents: 0,
        fiscalYear: year,
      );

      expect(result.taxableBaseInCents, 5000000);
      expect(result.estimatedRefundInCents, 0);
      // Tax with and without deductions should be equal
      expect(
        result.taxWithDeductionsInCents,
        result.taxWithoutDeductionsInCents,
      );
    });

    test('deductions exceed income — taxable base clamped to 0', () {
      final result = service.simulate(
        grossIncomeInCents: 1000000,
        totalDeductibleInCents: 2000000,
        fiscalYear: year,
      );

      expect(result.taxableBaseInCents, 0);
      // gross 1000000 is in the exempt bracket, so both taxes are 0
      expect(result.taxWithoutDeductionsInCents, 0);
      expect(result.taxWithDeductionsInCents, 0);
      expect(result.estimatedRefundInCents, 0);
    });

    test('exempt income — no tax and no refund', () {
      final result = service.simulate(
        grossIncomeInCents: 2000000,
        totalDeductibleInCents: 500000,
        fiscalYear: year,
      );

      expect(result.taxableBaseInCents, 1500000);
      expect(result.taxWithoutDeductionsInCents, 0);
      expect(result.taxWithDeductionsInCents, 0);
      expect(result.estimatedRefundInCents, 0);
    });

    test('effective rate matches formula', () {
      final result = service.simulate(
        grossIncomeInCents: 10000000,
        totalDeductibleInCents: 2000000,
        fiscalYear: year,
      );

      final expected = double.parse(
        (result.taxWithDeductionsInCents / result.grossIncomeInCents * 100)
            .toStringAsFixed(2),
      );
      expect(result.effectiveRatePercent, expected);
    });
  });
}
