import 'package:drift/drift.dart';

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

abstract final class AppSettingsKeys {
  static const monthlyReminderEnabled = 'monthly_reminder_enabled';
  static const bannerDismissedAt = 'banner_dismissed_at';
  static const summaryLastAccessedYear = 'summary_last_accessed_year';
  static const reminderFrequency = 'reminder_frequency';
  static const reminderTimeOfDay = 'reminder_time_of_day';
}

enum ReminderFrequency { none, daily, weekly, monthly }

extension ReminderFrequencyX on ReminderFrequency {
  String get label => switch (this) {
        ReminderFrequency.none => 'Desativado',
        ReminderFrequency.daily => 'Diário',
        ReminderFrequency.weekly => 'Semanal',
        ReminderFrequency.monthly => 'Mensal',
      };
}

enum ReminderTimeOfDay { morning, afternoon, evening }

extension ReminderTimeOfDayX on ReminderTimeOfDay {
  int get hour => switch (this) {
        ReminderTimeOfDay.morning => 8,
        ReminderTimeOfDay.afternoon => 13,
        ReminderTimeOfDay.evening => 20,
      };

  String get label => switch (this) {
        ReminderTimeOfDay.morning => 'Manhã 8h',
        ReminderTimeOfDay.afternoon => 'Tarde 13h',
        ReminderTimeOfDay.evening => 'Noite 20h',
      };
}
