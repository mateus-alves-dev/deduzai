import 'package:deduzai/core/domain/models/category.dart';
import 'package:deduzai/features/expense_entry/domain/cnpj_categorization_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_database.dart';

void main() {
  group('CnpjCategorizationService', () {
    late CnpjCategorizationService service;

    setUp(() {
      final db = createTestDatabase();
      service = CnpjCategorizationService(db.cnpjPreferenceDao);
    });

    // Spec 3.2 — CNPJ não reconhecido
    test('returns null for unknown CNPJ', () async {
      final result = await service.suggestCategory('12345678000199');

      expect(result, isNull);
    });

    // Spec 3.3 — Aprendizado: salva e sugere na próxima ocorrência
    test('suggests saved category for known CNPJ', () async {
      const cnpj = '12345678000199';
      await service.savePreference(cnpj, DeductionCategory.saude);

      final result = await service.suggestCategory(cnpj);

      expect(result, DeductionCategory.saude);
    });

    // Spec 3.3 — Preferência do usuário sobrescreve valor anterior
    test(
      'updates preference when user changes category for same CNPJ',
      () async {
        const cnpj = '12345678000199';
        await service.savePreference(cnpj, DeductionCategory.saude);
        await service.savePreference(cnpj, DeductionCategory.educacao);

        final result = await service.suggestCategory(cnpj);

        expect(result, DeductionCategory.educacao);
      },
    );

    // Spec 3.2 — CNPJs distintos não interferem entre si
    test('different CNPJs are stored independently', () async {
      const cnpjA = '11111111000111';
      const cnpjB = '22222222000122';
      await service.savePreference(cnpjA, DeductionCategory.saude);
      await service.savePreference(cnpjB, DeductionCategory.educacao);

      expect(await service.suggestCategory(cnpjA), DeductionCategory.saude);
      expect(await service.suggestCategory(cnpjB), DeductionCategory.educacao);
    });
  });
}
