import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service.g.dart';

const _monthlyReminderId = 1001;
const _irSeasonReminderId = 1002;

const _channelId = 'deduzai_reminders';
const _channelName = 'Lembretes DeduzAí';

const _defaultDetails = NotificationDetails(
  android: AndroidNotificationDetails(_channelId, _channelName),
  iOS: DarwinNotificationDetails(),
);

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize({
    void Function(String payload)? onNotificationTap,
  }) async {
    tz.initializeTimeZones();

    final plugin = NotificationService.instance._plugin;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null && onNotificationTap != null) {
          onNotificationTap(payload);
        }
      },
    );
  }

  Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return (await android?.areNotificationsEnabled()) ?? false;
    } else if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final settings = await ios?.checkPermissions();
      return settings?.isEnabled ?? false;
    }
    return false;
  }

  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      return (await android?.requestNotificationsPermission()) ?? false;
    } else if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      return (await ios?.requestPermissions(alert: true, sound: true)) ?? false;
    }
    return false;
  }

  /// Schedules a one-off or repeating monthly reminder at [fireAt].
  Future<void> scheduleMonthlyReminder(DateTime fireAt) async {
    await _plugin.cancel(id: _monthlyReminderId);
    await _plugin.zonedSchedule(
      id: _monthlyReminderId,
      title: 'DeduzAí',
      body:
          'Você registrou gastos dedutíveis este mês? '
          'Não esqueça remédios, consultas e terapia.',
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
      notificationDetails: _defaultDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// Schedules a daily reminder at [hour]:00, repeating every day.
  Future<void> scheduleDailyReminder(int hour) async {
    await _plugin.cancel(id: _monthlyReminderId);
    final now = DateTime.now();
    var fireAt = DateTime(now.year, now.month, now.day, hour);
    if (!now.isBefore(fireAt)) {
      fireAt = fireAt.add(const Duration(days: 1));
    }
    await _plugin.zonedSchedule(
      id: _monthlyReminderId,
      title: 'DeduzAí',
      body: 'Lembrete: registre seus gastos dedutíveis de hoje.',
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
      notificationDetails: _defaultDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedules a weekly reminder on Monday at [hour]:00.
  Future<void> scheduleWeeklyReminder(int hour) async {
    await _plugin.cancel(id: _monthlyReminderId);
    final now = DateTime.now();
    var fireAt = DateTime(now.year, now.month, now.day, hour);
    // Days until next Monday (0 means today is Monday)
    final daysUntilMonday = (DateTime.monday - now.weekday + 7) % 7;
    if (daysUntilMonday == 0 && !now.isBefore(fireAt)) {
      // Today is Monday but time has passed — schedule for next Monday
      fireAt = fireAt.add(const Duration(days: 7));
    } else {
      fireAt = fireAt.add(Duration(days: daysUntilMonday));
    }
    await _plugin.zonedSchedule(
      id: _monthlyReminderId,
      title: 'DeduzAí',
      body: 'Lembrete semanal: registre os gastos dedutíveis da semana.',
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
      notificationDetails: _defaultDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleIrSeasonReminder(DateTime fireAt, int year) async {
    await _plugin.cancel(id: _irSeasonReminderId);
    await _plugin.zonedSchedule(
      id: _irSeasonReminderId,
      title: 'DeduzAí',
      body:
          'A época do IR chegou. Seus gastos de $year estão '
          'organizados. Veja o resumo.',
      scheduledDate: tz.TZDateTime.from(fireAt, tz.local),
      notificationDetails: _defaultDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: 'summary:$year',
    );
  }

  Future<void> cancelMonthlyReminder() =>
      _plugin.cancel(id: _monthlyReminderId);

  Future<void> cancelIrSeasonReminder() =>
      _plugin.cancel(id: _irSeasonReminderId);
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) =>
    NotificationService.instance;
