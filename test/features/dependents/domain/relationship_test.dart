import 'package:deduzai/core/domain/models/relationship.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Relationship', () {
    test('fromValue returns correct enum member', () {
      expect(Relationship.fromValue('FILHO'), Relationship.filho);
      expect(Relationship.fromValue('ENTEADO'), Relationship.enteado);
      expect(Relationship.fromValue('CONJUGE'), Relationship.conjuge);
      expect(Relationship.fromValue('PAI_MAE'), Relationship.paiMae);
      expect(Relationship.fromValue('MENOR'), Relationship.menor);
      expect(Relationship.fromValue('OUTRO'), Relationship.outro);
    });

    test('fromValue falls back to outro for unknown values', () {
      expect(Relationship.fromValue('UNKNOWN'), Relationship.outro);
      expect(Relationship.fromValue(''), Relationship.outro);
    });

    test('label returns Portuguese description', () {
      expect(Relationship.filho.label, 'Filho(a)');
      expect(Relationship.conjuge.label, 'Cônjuge / Companheiro(a)');
    });

    test('value matches stored DB string', () {
      expect(Relationship.filho.value, 'FILHO');
      expect(Relationship.paiMae.value, 'PAI_MAE');
    });
  });
}
