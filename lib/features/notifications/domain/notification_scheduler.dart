import 'package:deduzai/core/database/daos/app_settings_dao.dart';
import 'package:deduzai/core/database/daos/expense_dao.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:deduzai/features/notifications/data/notification_service.dart';
import 'package:deduzai/features/notifications/domain/business_day_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_scheduler.g.dart';

@riverpod
NotificationScheduler notificationScheduler(Ref ref) => NotificationScheduler(
      ref.watch(notificationServiceProvider),
      ref.watch(appSettingsDaoProvider),
      ref.watch(expenseDaoProvider),
    );

class NotificationScheduler {
  NotificationScheduler(this._service, this._settings, this._expenseDao);

  final NotificationService _service;
  final AppSettingsDao _settings;
  final ExpenseDao _expenseDao;

  Future<void> scheduleAll() async {
    final now = DateTime.now();
    await _scheduleReminder(now);
    await _scheduleIrSeasonReminder(now);
  }

  // ── Reminder (daily / weekly / monthly / none) ──────────────────────────

  Future<void> _scheduleReminder(DateTime now) async {
    final frequency = await _readFrequency();
    final tod = await _readTimeOfDay();
    final hour = tod.hour;

    switch (frequency) {
      case ReminderFrequency.none:
        await _service.cancelMonthlyReminder();
      case ReminderFrequency.daily:
        await _service.scheduleDailyReminder(hour);
      case ReminderFrequency.weekly:
        await _service.scheduleWeeklyReminder(hour);
      case ReminderFrequency.monthly:
        await _scheduleForMonth(now, now.year, now.month, hour);
        // Pre-schedule next month if current trigger has passed
        final nextMonth = now.month == 12 ? 1 : now.month + 1;
        final nextYear = now.month == 12 ? now.year + 1 : now.year;
        final currentTrigger =
            BusinessDayHelper.monthlyReminderTrigger(now.year, now.month, hour);
        final nextTrigger =
            BusinessDayHelper.monthlyReminderTrigger(nextYear, nextMonth, hour);
        if (now.isAfter(currentTrigger) && nextTrigger.isAfter(now)) {
          await _service.scheduleMonthlyReminder(nextTrigger);
        }
    }
  }

  Future<void> _scheduleForMonth(
    DateTime now,
    int year,
    int month,
    int hour,
  ) async {
    final trigger =
        BusinessDayHelper.monthlyReminderTrigger(year, month, hour);

    if (trigger.isAfter(now)) {
      await _service.scheduleMonthlyReminder(trigger);
      return;
    }

    // Trigger date has passed — check if user has expenses.
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    if (now.isAfter(lastDayOfMonth)) return; // Month ended

    final count = await _expenseDao.countExpensesInMonth(year, month);
    if (count > 0) {
      await _service.cancelMonthlyReminder();
    } else {
      // No expenses yet — fire as soon as possible at the user's chosen hour.
      final todayAtHour = DateTime(now.year, now.month, now.day, hour);
      final fireAt = now.isAfter(todayAtHour)
          ? DateTime(now.year, now.month, now.day + 1, hour)
          : todayAtHour;
      if (fireAt.isBefore(lastDayOfMonth)) {
        await _service.scheduleMonthlyReminder(fireAt);
      }
    }
  }

  Future<ReminderFrequency> _readFrequency() async {
    final raw = await _settings.getValue(AppSettingsKeys.reminderFrequency);
    if (raw != null) {
      return ReminderFrequency.values.firstWhere(
        (f) => f.name == raw,
        orElse: () => ReminderFrequency.monthly,
      );
    }
    // Backwards compat: migrate from old monthlyReminderEnabled key.
    final legacy =
        await _settings.getValue(AppSettingsKeys.monthlyReminderEnabled);
    return legacy == 'false' ? ReminderFrequency.none : ReminderFrequency.monthly;
  }

  Future<ReminderTimeOfDay> _readTimeOfDay() async {
    final raw = await _settings.getValue(AppSettingsKeys.reminderTimeOfDay);
    return ReminderTimeOfDay.values.firstWhere(
      (t) => t.name == raw,
      orElse: () => ReminderTimeOfDay.morning,
    );
  }

  // ── Spec 6.2 — IR season reminder ─────────────────────────────────────

  Future<void> _scheduleIrSeasonReminder(DateTime now) async {
    if (now.month != 3) return; // Only relevant in March.

    final lastYear = now.year - 1;
    final accessedYearRaw =
        await _settings.getValue(AppSettingsKeys.summaryLastAccessedYear);

    if (accessedYearRaw == lastYear.toString()) {
      await _service.cancelIrSeasonReminder();
      return;
    }

    final march5 = DateTime(now.year, 3, 5, 9);
    final tomorrow9 = DateTime(now.year, now.month, now.day + 1, 9);
    final fireAt = now.isBefore(march5) ? march5 : tomorrow9;

    final endOfMarch = DateTime(now.year, 4);
    if (fireAt.isBefore(endOfMarch)) {
      await _service.scheduleIrSeasonReminder(fireAt, lastYear);
    }
  }
}
