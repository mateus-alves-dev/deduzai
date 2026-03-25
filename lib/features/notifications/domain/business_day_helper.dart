abstract final class BusinessDayHelper {
  /// Returns the last business day (Mon–Fri) of the given [month]/[year].
  static DateTime lastBusinessDayOfMonth(int year, int month) {
    // Last calendar day of the month.
    var day = DateTime(year, month + 1, 0); // day 0 of next month = last day
    while (day.weekday == DateTime.saturday ||
        day.weekday == DateTime.sunday) {
      day = day.subtract(const Duration(days: 1));
    }
    return DateTime(day.year, day.month, day.day);
  }

  /// Returns [date] minus [n] business days (skips weekends; no holidays).
  static DateTime subtractBusinessDays(DateTime date, int n) {
    var result = date;
    var remaining = n;
    while (remaining > 0) {
      result = result.subtract(const Duration(days: 1));
      if (result.weekday != DateTime.saturday &&
          result.weekday != DateTime.sunday) {
        remaining--;
      }
    }
    return result;
  }

  /// The D-2 trigger date (2 business days before last business day of month)
  /// at [hour]:00 local time. Defaults to 08:00 if not specified.
  static DateTime monthlyReminderTrigger(int year, int month, [int hour = 8]) {
    final lastBd = lastBusinessDayOfMonth(year, month);
    final trigger = subtractBusinessDays(lastBd, 2);
    return DateTime(trigger.year, trigger.month, trigger.day, hour);
  }
}
