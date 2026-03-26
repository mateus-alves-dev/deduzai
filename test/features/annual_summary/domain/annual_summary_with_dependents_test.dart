import 'package:deduzai/core/domain/models/deduction_caps.dart';
import 'package:deduzai/features/annual_summary/domain/annual_summary_service.dart';
import 'package:deduzai/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = AnnualSummaryService();
  const year = 2025;

  Expense _makeExpense({
    required String category,
    required int amountInCents,
    DateTime? date,
  }) {
    final now = date ?? DateTime(year, 6, 15);
    return Expense(
      id: 'exp-${now.millisecondsSinceEpoch}-$amountInCents',
      date: now,
      category: category,
      amountInCents: amountInCents,
      description: 'Test expense',
      origem: 'MANUAL',
      createdAt: now,
      updatedAt: null,
      deletedAt: null,
      receiptPath: null,
      beneficiario: null,
      cnpj: null,
    );
  }

  group('AnnualSummaryService with dependents', () {
    test('zero dependents — no dependent deduction', () {
      final expenses = [
        _makeExpense(category: 'saude', amountInCents: 100000),
      ];

      final result = service.computeSync(expenses, year, dependentCount: 0);

      expect(result.dependentCount, 0);
      expect(result.dependentDeductionInCents, 0);
      expect(result.totalDeductibleInCents, 100000);
    });

    test('one dependent — adds fixed deduction', () {
      final expenses = [
        _makeExpense(category: 'saude', amountInCents: 100000),
      ];

      final result = service.computeSync(expenses, year, dependentCount: 1);

      final perDep = DeductionCaps.dependentDeductionFor(year);
      expect(result.dependentCount, 1);
      expect(result.dependentDeductionInCents, perDep);
      expect(result.totalDeductibleInCents, 100000 + perDep);
    });

    test('three dependents — multiplied deduction', () {
      final expenses = [
        _makeExpense(category: 'saude', amountInCents: 50000),
      ];

      final result = service.computeSync(expenses, year, dependentCount: 3);

      final perDep = DeductionCaps.dependentDeductionFor(year);
      expect(result.dependentCount, 3);
      expect(result.dependentDeductionInCents, perDep * 3);
      expect(result.totalDeductibleInCents, 50000 + perDep * 3);
    });

    test('no expenses but has dependents — not empty', () {
      final result = service.computeSync([], year, dependentCount: 2);

      expect(result.isEmpty, false);
      expect(result.categories, isEmpty);
      expect(result.dependentCount, 2);
      expect(
        result.dependentDeductionInCents,
        DeductionCaps.dependentDeductionFor(year) * 2,
      );
      expect(
        result.totalDeductibleInCents,
        result.dependentDeductionInCents,
      );
    });

    test('education cap multiplied by (1 + dependentCount)', () {
      // Education cap for 2025 is R$ 3.561,50 = 356150 centavos.
      // With 2 dependents, cap should be 356150 * 3 = 1068450.
      final expenses = [
        _makeExpense(
          category: 'educacao',
          amountInCents: 900000, // R$ 9.000
        ),
      ];

      final withoutDeps =
          service.computeSync(expenses, year, dependentCount: 0);
      final withDeps =
          service.computeSync(expenses, year, dependentCount: 2);

      // Without dependents: capped at 356150
      final educWithout = withoutDeps.categories
          .firstWhere((c) => c.category.name == 'educacao');
      expect(educWithout.deductibleInCents, 356150);
      expect(educWithout.surplusInCents, 900000 - 356150);

      // With 2 dependents: cap is 356150 * 3 = 1068450
      final educWith = withDeps.categories
          .firstWhere((c) => c.category.name == 'educacao');
      expect(educWith.capInCents, 356150 * 3);
      expect(educWith.deductibleInCents, 900000); // under new cap
      expect(educWith.surplusInCents, null); // no surplus
    });

    test('education cap exceeded even with dependents', () {
      // R$ 15.000 should exceed cap even with 2 deps (cap = 356150 * 3)
      final expenses = [
        _makeExpense(
          category: 'educacao',
          amountInCents: 1500000,
        ),
      ];

      final result =
          service.computeSync(expenses, year, dependentCount: 2);

      final educ = result.categories
          .firstWhere((c) => c.category.name == 'educacao');
      final expectedCap = 356150 * 3;
      expect(educ.capInCents, expectedCap);
      expect(educ.deductibleInCents, expectedCap);
      expect(educ.surplusInCents, 1500000 - expectedCap);
    });
  });

  group('DeductionCaps.dependentDeductionFor', () {
    test('known year returns correct value', () {
      expect(DeductionCaps.dependentDeductionFor(2025), 227508);
    });

    test('unknown year falls back to default', () {
      expect(DeductionCaps.dependentDeductionFor(2030), 227508);
    });
  });
}
