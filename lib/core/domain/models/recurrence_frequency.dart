enum RecurrenceFrequency {
  semanal('SEMANAL'),
  quinzenal('QUINZENAL'),
  mensal('MENSAL'),
  anual('ANUAL');

  const RecurrenceFrequency(this.value);

  final String value;

  String get label => switch (this) {
        RecurrenceFrequency.semanal => 'Semanal',
        RecurrenceFrequency.quinzenal => 'Quinzenal',
        RecurrenceFrequency.mensal => 'Mensal',
        RecurrenceFrequency.anual => 'Anual',
      };

  static RecurrenceFrequency fromValue(String v) =>
      values.firstWhere((e) => e.value == v, orElse: () => mensal);
}
