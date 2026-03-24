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
    await _scheduleMonthlyReminder(now);
    await _scheduleIrSeasonReminder(now);
  }

  // ── Spec 6.1 — Monthly reminder ────────────────────────────────────────

  Future<void> _scheduleMonthlyReminder(DateTime now) async {
    final enabledRaw =
        await _settings.getValue(AppSettingsKeys.monthlyReminderEnabled);
    final enabled = enabledRaw != 'false'; // default true

    if (!enabled) {
      await _service.cancelMonthlyReminder();
      return;
    }

    // Schedule for current month.
    await _scheduleForMonth(now, now.year, now.month);

    // Always also schedule for next month so the reminder survives between
    // app opens even when the user doesn't open the app near month-end.
    final nextMonth = now.month == 12 ? 1 : now.month + 1;
    final nextYear = now.month == 12 ? now.year + 1 : now.year;
    final nextTrigger =
        BusinessDayHelper.monthlyReminderTrigger(nextYear, nextMonth);
    // Only schedule next month if it's in the future and would override the
    // current-month notification. We re-schedule: cancel then set.
    // Since we can only have one scheduled ID 1001 at a time, we only set
    // the next-month trigger if the current month trigger has already passed
    // (handled inside _scheduleForMonth, which cancels when count >= 1).
    // We handle this by scheduling next month only if we didn't schedule for
    // the current month AND the trigger is in the future.
    final currentTrigger =
        BusinessDayHelper.monthlyReminderTrigger(now.year, now.month);
    if (now.isAfter(currentTrigger) && nextTrigger.isAfter(now)) {
      await _service.scheduleMonthlyReminder(nextTrigger);
    }
  }

  Future<void> _scheduleForMonth(DateTime now, int year, int month) async {
    final trigger = BusinessDayHelper.monthlyReminderTrigger(year, month);

    if (trigger.isAfter(now)) {
      // Trigger date is still in the future — schedule for it.
      await _service.scheduleMonthlyReminder(trigger);
      return;
    }

    // Trigger date has passed or is today — check if user has expenses.
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    if (now.isAfter(lastDayOfMonth)) {
      // Month already ended — nothing to schedule for this month.
      return;
    }

    final count = await _expenseDao.countExpensesInMonth(year, month);
    if (count > 0) {
      await _service.cancelMonthlyReminder();
    } else {
      // No expenses yet — fire as soon as possible (next day at 10:00 if
      // it's already past 10:00, otherwise today at 10:00).
      final today10 = DateTime(now.year, now.month, now.day, 10);
      final fireAt = now.isAfter(today10)
          ? DateTime(now.year, now.month, now.day + 1, 10)
          : today10;
      if (fireAt.isBefore(lastDayOfMonth)) {
        await _service.scheduleMonthlyReminder(fireAt);
      }
    }
  }

  // ── Spec 6.2 — IR season reminder ─────────────────────────────────────

  Future<void> _scheduleIrSeasonReminder(DateTime now) async {
    if (now.month != 3) return; // Only relevant in March.

    final lastYear = now.year - 1;
    final accessedYearRaw =
        await _settings.getValue(AppSettingsKeys.summaryLastAccessedYear);

    if (accessedYearRaw == lastYear.toString()) {
      // User already accessed the summary for the last fiscal year.
      await _service.cancelIrSeasonReminder();
      return;
    }

    // Schedule notification. Prefer March 5 at 09:00; if already past, use
    // tomorrow at 09:00.
    final march5 = DateTime(now.year, 3, 5, 9);
    final tomorrow9 = DateTime(now.year, now.month, now.day + 1, 9);
    final fireAt = now.isBefore(march5) ? march5 : tomorrow9;

    // Only schedule if still within March.
    final endOfMarch = DateTime(now.year, 4);
    if (fireAt.isBefore(endOfMarch)) {
      await _service.scheduleIrSeasonReminder(fireAt, lastYear);
    }
  }
}
