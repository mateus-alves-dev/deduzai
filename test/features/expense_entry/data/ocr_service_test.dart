import 'package:deduzai/core/domain/models/ocr_result.dart';
import 'package:deduzai/features/expense_entry/data/ocr_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OcrService service;

  setUp(() {
    service = OcrService();
  });

  group('OcrService.parseText', () {
    test('extracts valor from R\$ pattern', () {
      const text = '''
SUPERMERCADO XYZ LTDA
CNPJ: 12.345.678/0001-90
Data: 15/03/2026
TOTAL R\$ 123,45
''';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.valor, 12345);
      expect(result.status, OcrStatus.success);
    });

    test('extracts valor from TOTAL pattern without R\$', () {
      const text = '''
FARMÁCIA POPULAR
TOTAL 89,90
Data 10/01/2026
''';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.valor, 8990);
    });

    test('extracts data no formato dd/MM/yyyy', () {
      const text = 'Data de emissão: 22/06/2025\nValor: R\$ 50,00';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.data?.day, 22);
      expect(result.data?.month, 6);
      expect(result.data?.year, 2025);
    });

    test('ignores future dates', () {
      const text = 'Data: 01/01/2090\nR\$ 10,00';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.data, isNull);
    });

    test('extracts CNPJ with formatting', () {
      const text = 'CNPJ: 12.345.678/0001-90\nR\$ 200,00';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.cnpj, '12345678000190');
    });

    test('extracts CNPJ without formatting', () {
      const text = 'CNPJ 12345678000190\nTotal R\$ 50,00';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.cnpj, '12345678000190');
    });

    test('returns partial status when only date extracted', () {
      const text = 'Data: 10/03/2026';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.status, OcrStatus.partial);
      expect(result.valor, isNull);
      expect(result.cnpj, isNull);
      expect(result.data, isNotNull);
    });

    test('returns failure status when nothing extracted', () {
      // All lines start with digits or are too short — nothing extractable
      const text = '123 456\n789\n0 0 0';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.status, OcrStatus.failure);
      expect(result.valor, isNull);
      expect(result.data, isNull);
      expect(result.cnpj, isNull);
      expect(result.beneficiario, isNull);
    });

    test('extracts beneficiario from first non-numeric line', () {
      const text =
          r'CLÍNICA MÉDICA SÃO LUCAS' '\n' r'12.345.678/0001-90' '\nR\$ 300,00';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.beneficiario, 'CLÍNICA MÉDICA SÃO LUCAS');
    });

    test('handles valor with dot thousand separator', () {
      const text = 'TOTAL R\$ 1.234,56';
      final result = service.parseText(text, '/fake/path.jpg');
      expect(result.valor, 123456);
    });

    test('handles empty text', () {
      final result = service.parseText('', '/fake/path.jpg');
      expect(result.status, OcrStatus.failure);
    });
  });
}
