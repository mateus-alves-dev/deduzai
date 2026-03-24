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
}
