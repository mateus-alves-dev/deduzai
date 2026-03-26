import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/features/expense_entry/data/ocr_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const imagePath = '/test/image.jpg';
  late OcrService service;

  setUp(() {
    service = OcrService();
  });

  // ---------------------------------------------------------------------------
  // Valor extraction
  // ---------------------------------------------------------------------------
  group('Valor extraction', () {
    test('keyword TOTAL followed by amount', () {
      final result = service.parseText('TOTAL  R\$ 123,45', imagePath);
      expect(result.valor, 12345);
    });

    test('keyword VALOR TOTAL with thousand separators', () {
      final result = service.parseText('VALOR TOTAL: 1.234,56', imagePath);
      expect(result.valor, 123456);
    });

    test('multi-line: keyword on one line, amount on next', () {
      final result = service.parseText('TOTAL\n123,45', imagePath);
      expect(result.valor, 12345);
    });

    test('R\$ fallback picks largest amount', () {
      final result = service.parseText(
        'Serviço R\$ 50,00\nOutro R\$ 200,00',
        imagePath,
      );
      expect(result.valor, 20000);
    });

    test('standalone amount fallback (stage 3)', () {
      final result = service.parseText(
        'texto qualquer 99,90 mais texto',
        imagePath,
      );
      expect(result.valor, 9990);
    });

    test('guard: amount exceeding R\$ 1.000.000 is ignored', () {
      final result = service.parseText('TOTAL 2.000.000,00', imagePath);
      expect(result.valor, isNull);
    });

    test('VLR TOTAL keyword variation', () {
      final result = service.parseText('VLR TOTAL 89,99', imagePath);
      expect(result.valor, 8999);
    });

    test('empty text returns null valor', () {
      final result = service.parseText('no amounts here', imagePath);
      expect(result.valor, isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // Data (date) extraction
  // ---------------------------------------------------------------------------
  group('Data (date) extraction', () {
    test('standard DD/MM/YYYY format', () {
      final result = service.parseText('DATA: 15/03/2025', imagePath);
      expect(result.data, DateTime(2025, 3, 15));
    });

    test('two-digit year', () {
      final result = service.parseText('15/03/25', imagePath);
      expect(result.data, DateTime(2025, 3, 15));
    });

    test('keyword priority over positional date', () {
      final result = service.parseText(
        '01/01/2024\nDATA EMISSAO: 15/03/2025',
        imagePath,
      );
      expect(result.data, DateTime(2025, 3, 15));
    });

    test('most recent date when no keyword', () {
      final result = service.parseText('01/06/2024\n15/08/2024', imagePath);
      expect(result.data, DateTime(2024, 8, 15));
    });

    test('future date is rejected', () {
      final future = DateTime.now().add(const Duration(days: 30));
      final dd = future.day.toString().padLeft(2, '0');
      final mm = future.month.toString().padLeft(2, '0');
      final yyyy = future.year.toString();
      final result = service.parseText('$dd/$mm/$yyyy', imagePath);
      expect(result.data, isNull);
    });

    test('no date returns null', () {
      final result = service.parseText('no dates here', imagePath);
      expect(result.data, isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // CNPJ extraction
  // ---------------------------------------------------------------------------
  group('CNPJ extraction', () {
    test('valid CNPJ with dots/slashes', () {
      final result = service.parseText(
        'CNPJ: 11.222.333/0001-81',
        imagePath,
      );
      expect(result.cnpj, '11222333000181');
    });

    test('valid CNPJ digits only', () {
      final result = service.parseText('11222333000181', imagePath);
      expect(result.cnpj, '11222333000181');
    });

    test('invalid CNPJ returned as fallback', () {
      // Last digit changed from 1 to 9 — fails modulo-11 check
      final result = service.parseText('11.222.333/0001-99', imagePath);
      expect(result.cnpj, '11222333000199');
    });

    test('OCR-corrupted digit (O instead of 0) is not matched by regex', () {
      // The current regex requires \\d in all digit positions, so an 'O'
      // character prevents the pattern from matching entirely. The OCR
      // correction path (_applyCnpjOcrFixes) can only run on already-
      // matched text, making digit-position OCR fixes unreachable.
      final result = service.parseText(
        'CNPJ: 11.222.333/O001-81',
        imagePath,
      );
      expect(result.cnpj, isNull);
    });

    test('multiple CNPJs: skips invalid, returns first valid', () {
      final result = service.parseText(
        'CNPJ: 11.222.333/0001-99\nCNPJ: 11.444.777/0001-61',
        imagePath,
      );
      expect(result.cnpj, '11444777000161');
    });

    test('no CNPJ returns null', () {
      final result = service.parseText('no cnpj here', imagePath);
      expect(result.cnpj, isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // Beneficiário extraction
  // ---------------------------------------------------------------------------
  group('Beneficiário extraction', () {
    test('keyword RAZAO SOCIAL match', () {
      final result = service.parseText(
        'RAZAO SOCIAL: FARMACIA CENTRAL LTDA',
        imagePath,
      );
      expect(result.beneficiario, 'FARMACIA CENTRAL LTDA');
    });

    test('uppercase line scores higher', () {
      final result = service.parseText(
        'nota fiscal\nFARMACIA CENTRAL LTDA\n123 rua abc',
        imagePath,
      );
      expect(result.beneficiario, 'FARMACIA CENTRAL LTDA');
    });

    test('address lines are skipped', () {
      final result = service.parseText(
        'Rua das Flores 123\nLOJA ABC LTDA',
        imagePath,
      );
      expect(result.beneficiario, 'LOJA ABC LTDA');
    });

    test('truncates at 80 characters', () {
      final longName = 'A' * 100;
      final result = service.parseText(longName, imagePath);
      expect(result.beneficiario, hasLength(80));
      expect(result.beneficiario, 'A' * 80);
    });

    test('empty text returns null', () {
      final result = service.parseText('', imagePath);
      expect(result.beneficiario, isNull);
    });

    test('NOME FANTASIA keyword', () {
      final result = service.parseText(
        'NOME FANTASIA: Drogasil',
        imagePath,
      );
      expect(result.beneficiario, 'Drogasil');
    });
  });

  // ---------------------------------------------------------------------------
  // OcrStatus logic
  // ---------------------------------------------------------------------------
  group('OcrStatus logic', () {
    test('success when valor is extracted', () {
      final result = service.parseText('TOTAL 50,00', imagePath);
      expect(result.status, OcrStatus.success);
      expect(result.valor, isNotNull);
    });

    test('partial when no valor but has CNPJ', () {
      // Plain digit CNPJ with no monetary separators to avoid valor detection
      final result = service.parseText('CNPJ\n11222333000181', imagePath);
      expect(result.status, OcrStatus.partial);
      expect(result.valor, isNull);
      expect(result.cnpj, isNotNull);
    });

    test('failure when nothing extracted', () {
      final result = service.parseText('', imagePath);
      expect(result.status, OcrStatus.failure);
      expect(result.valor, isNull);
      expect(result.cnpj, isNull);
      expect(result.data, isNull);
      expect(result.beneficiario, isNull);
    });
  });
}
