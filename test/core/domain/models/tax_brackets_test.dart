import 'package:deduzai/core/domain/models/tax_brackets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TaxBrackets.computeTaxInCents (2025)', () {
    test('exempt bracket — income well below limit', () {
      expect(TaxBrackets.computeTaxInCents(2000000, 2025), 0);
    });

    test('exempt at boundary — exactly at 0% upper limit', () {
      expect(TaxBrackets.computeTaxInCents(2696320, 2025), 0);
    });

    test('7.5% bracket', () {
      // (3000000 * 7.5 / 100) - 202224 = 225000 - 202224 = 22776
      expect(TaxBrackets.computeTaxInCents(3000000, 2025), 22776);
    });

    test('15% bracket', () {
      // (4000000 * 15 / 100) - 456623 = 600000 - 456623 = 143377
      expect(TaxBrackets.computeTaxInCents(4000000, 2025), 143377);
    });

    test('22.5% bracket', () {
      // (5000000 * 22.5 / 100) - 794317 = 1125000 - 794317 = 330683
      expect(TaxBrackets.computeTaxInCents(5000000, 2025), 330683);
    });

    test('27.5% bracket', () {
      // (10000000 * 27.5 / 100) - 1074098 = 2750000 - 1074098 = 1675902
      expect(TaxBrackets.computeTaxInCents(10000000, 2025), 1675902);
    });

    test('zero income returns 0', () {
      expect(TaxBrackets.computeTaxInCents(0, 2025), 0);
    });

    test('negative income returns 0', () {
      expect(TaxBrackets.computeTaxInCents(-100, 2025), 0);
    });
  });

  group('TaxBrackets.computeTaxInCents — year comparison', () {
    test('2023 table differs from 2025 near exempt boundary', () {
      const income = 2600000;

      // 2023 exempt limit is 2499648 → income is taxable
      // (2600000 * 7.5 / 100) - 187474 = 195000 - 187474 = 7526
      expect(TaxBrackets.computeTaxInCents(income, 2023), 7526);

      // 2025 exempt limit is 2696320 → income is still exempt
      expect(TaxBrackets.computeTaxInCents(income, 2025), 0);
    });
  });

  group('TaxBrackets.forYear', () {
    test('unsupported year throws ArgumentError', () {
      expect(() => TaxBrackets.forYear(2020), throwsArgumentError);
    });

    test('supported year returns 5 brackets', () {
      final brackets = TaxBrackets.forYear(2025);
      expect(brackets, hasLength(5));
    });
  });
}
