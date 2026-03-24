enum DeductionCategory {
  saude('Saúde'),
  educacao('Educação'),
  pensaoAlimenticia('Pensão Alimentícia'),
  previdenciaPrivada('Previdência Privada'),
  dependentes('Dependentes');

  const DeductionCategory(this.label);

  final String label;
}
