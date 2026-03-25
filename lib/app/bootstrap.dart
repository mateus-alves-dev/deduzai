import 'package:deduzai/app/app.dart';
import 'package:deduzai/app/flavors.dart';
import 'package:deduzai/app/router.dart';
import 'package:deduzai/features/notifications/data/notification_service.dart';
import 'package:deduzai/features/notifications/domain/notification_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> bootstrap(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');

  await NotificationService.initialize(
    onNotificationTap: (payload) {
      if (payload.startsWith('summary:')) {
        router.go('/summary');
      }
    },
  );

  final config = FlavorConfig.fromFlavor(flavor);

  // Schedule notifications using a temporary container before runApp.
  final container = ProviderContainer(
    overrides: [flavorConfigProvider.overrideWithValue(config)],
  );
  try {
    await container.read(notificationSchedulerProvider).scheduleAll();
  } finally {
    container.dispose();
  }

  runApp(
    ProviderScope(
      overrides: [
        flavorConfigProvider.overrideWithValue(config),
      ],
      child: const DeduzAiApp(),
    ),
  );
}

final flavorConfigProvider = Provider<FlavorConfig>(
  (ref) => throw UnimplementedError('flavorConfigProvider must be overridden'),
);
