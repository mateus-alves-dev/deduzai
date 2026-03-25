import 'package:deduzai/features/notifications/data/notification_service.dart';
import 'package:deduzai/features/notifications/presentation/providers/notification_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPermissionBanner extends ConsumerWidget {
  const NotificationPermissionBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldShowAsync =
        ref.watch(notificationBannerShouldShowProvider);

    return shouldShowAsync.maybeWhen(
      data: (shouldShow) {
        if (!shouldShow) return const SizedBox.shrink();
        return MaterialBanner(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          content: const Text(
            'Ative notificações para não esquecer gastos dedutíveis.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(notificationServiceProvider)
                    .requestPermission();
                ref.invalidate(notificationPermissionGrantedProvider);
              },
              child: const Text('Ativar'),
            ),
            TextButton(
              onPressed: () => ref
                  .read(notificationBannerProvider.notifier)
                  .dismiss(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
