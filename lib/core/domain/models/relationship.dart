/// Relationship types for tax dependents (Receita Federal categories).
enum Relationship {
  filho('FILHO'),
  enteado('ENTEADO'),
  conjuge('CONJUGE'),
  paiMae('PAI_MAE'),
  menor('MENOR'),
  outro('OUTRO');

  const Relationship(this.value);

  final String value;

  String get label => switch (this) {
        Relationship.filho => 'Filho(a)',
        Relationship.enteado => 'Enteado(a)',
        Relationship.conjuge => 'Cônjuge / Companheiro(a)',
        Relationship.paiMae => 'Pai / Mãe',
        Relationship.menor => 'Menor (guarda judicial)',
        Relationship.outro => 'Outro',
      };

  static Relationship fromValue(String v) =>
      values.firstWhere((e) => e.value == v, orElse: () => outro);
}
