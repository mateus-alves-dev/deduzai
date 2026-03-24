import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'notification_service.g.dart';

const _monthlyReminderId = 1001;
const _irSeasonReminderId = 1002;

const _channelId = 'deduzai_reminders';
const _channelName = 'Lembretes DeduzAí';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize({
    void Function(String payload)? onNotificationTap,
  }) async {
    tz.initializeTimeZones();

    final plugin = NotificationService.instance._plugin;

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await plugin.initialize(
      const InitializationSettings(
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
              AndroidFlutterLocalNotificationsPlugin>();
      return (await android?.areNotificationsEnabled()) ?? false;
    } else if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      final settings = await ios?.checkPermissions();
      return settings?.isEnabled ?? false;
    }
    return false;
  }

  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      return (await android?.requestNotificationsPermission()) ?? false;
    } else if (Platform.isIOS) {
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      return (await ios?.requestPermissions(alert: true, sound: true)) ?? false;
    }
    return false;
  }

  Future<void> scheduleMonthlyReminder(DateTime fireAt) async {
    await _plugin.cancel(_monthlyReminderId);
    await _plugin.zonedSchedule(
      _monthlyReminderId,
      'DeduzAí',
      'Você registrou gastos dedutíveis este mês? '
          'Não esqueça remédios, consultas e terapia.',
      tz.TZDateTime.from(fireAt, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleIrSeasonReminder(DateTime fireAt, int year) async {
    await _plugin.cancel(_irSeasonReminderId);
    await _plugin.zonedSchedule(
      _irSeasonReminderId,
      'DeduzAí',
      'A época do IR chegou. Seus gastos de $year estão '
          'organizados. Veja o resumo.',
      tz.TZDateTime.from(fireAt, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'summary:$year',
    );
  }

  Future<void> cancelMonthlyReminder() =>
      _plugin.cancel(_monthlyReminderId);

  Future<void> cancelIrSeasonReminder() =>
      _plugin.cancel(_irSeasonReminderId);
}

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) =>
    NotificationService.instance;
