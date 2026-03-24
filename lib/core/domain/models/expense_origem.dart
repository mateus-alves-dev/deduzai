enum ExpenseOrigem {
  manual('MANUAL'),
  ocr('OCR'),
  importado('IMPORTADO');

  const ExpenseOrigem(this.value);

  final String value;

  static ExpenseOrigem fromValue(String v) =>
      values.firstWhere((e) => e.value == v, orElse: () => manual);
}
