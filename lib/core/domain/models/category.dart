enum DeductionCategory {
  saude('Saúde'),
  educacao('Educação'),
  pensaoAlimenticia('Pensão Alimentícia'),
  previdenciaPrivada('Previdência Privada'),
  dependentes('Dependentes'),
  previdenciaSocial('Previdência Social (INSS)'),
  doacoesIncentivadas('Doações Incentivadas'),
  livroCaixa('Livro-Caixa');

  const DeductionCategory(this.label);

  final String label;
}
