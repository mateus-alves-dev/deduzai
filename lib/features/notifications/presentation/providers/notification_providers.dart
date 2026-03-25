import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:deduzai/features/notifications/data/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

@riverpod
Future<bool> notificationPermissionGranted(Ref ref) =>
    ref.watch(notificationServiceProvider).checkPermission();

@riverpod
Future<bool> notificationBannerShouldShow(Ref ref) async {
  final granted =
      await ref.watch(notificationPermissionGrantedProvider.future);
  if (granted) return false;

  final dao = ref.watch(appSettingsDaoProvider);
  final raw = await dao.getValue(AppSettingsKeys.bannerDismissedAt);
  if (raw == null) return true;

  final dismissedAt = DateTime.tryParse(raw);
  if (dismissedAt == null) return true;
  return DateTime.now().difference(dismissedAt).inDays >= 30;
}

@riverpod
class NotificationBannerNotifier extends _$NotificationBannerNotifier {
  @override
  void build() {}

  Future<void> dismiss() async {
    final dao = ref.read(appSettingsDaoProvider);
    await dao.setValue(
      AppSettingsKeys.bannerDismissedAt,
      DateTime.now().toIso8601String(),
    );
    ref.invalidate(notificationBannerShouldShowProvider);
  }
}

@riverpod
Future<bool> monthlyReminderEnabled(Ref ref) async {
  final dao = ref.watch(appSettingsDaoProvider);
  final raw = await dao.getValue(AppSettingsKeys.monthlyReminderEnabled);
  return raw != 'false'; // default true
}

@riverpod
Future<ReminderFrequency> reminderFrequency(Ref ref) async {
  final dao = ref.watch(appSettingsDaoProvider);
  final raw = await dao.getValue(AppSettingsKeys.reminderFrequency);
  if (raw != null) {
    return ReminderFrequency.values.firstWhere(
      (f) => f.name == raw,
      orElse: () => ReminderFrequency.monthly,
    );
  }
  // Backwards compat: read from legacy key.
  final legacy = await dao.getValue(AppSettingsKeys.monthlyReminderEnabled);
  return legacy == 'false' ? ReminderFrequency.none : ReminderFrequency.monthly;
}

@riverpod
Future<ReminderTimeOfDay> reminderTimeOfDay(Ref ref) async {
  final dao = ref.watch(appSettingsDaoProvider);
  final raw = await dao.getValue(AppSettingsKeys.reminderTimeOfDay);
  return ReminderTimeOfDay.values.firstWhere(
    (t) => t.name == raw,
    orElse: () => ReminderTimeOfDay.morning,
  );
}
