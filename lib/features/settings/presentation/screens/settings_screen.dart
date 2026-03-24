import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:deduzai/features/notifications/domain/notification_scheduler.dart';
import 'package:deduzai/features/notifications/presentation/providers/notification_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyEnabledAsync = ref.watch(monthlyReminderEnabledProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Comprovantes arquivados'),
            subtitle: const Text('Comprovantes de gastos excluídos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/receipts/archived'),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Lembrete mensal'),
            subtitle: const Text(
              'Notificação quando você não registrou gastos no mês',
            ),
            value: monthlyEnabledAsync.valueOrNull ?? true,
            onChanged: (enabled) async {
              final dao = ref.read(appSettingsDaoProvider);
              await dao.setValue(
                AppSettingsKeys.monthlyReminderEnabled,
                enabled ? 'true' : 'false',
              );
              await ref.read(notificationSchedulerProvider).scheduleAll();
              ref.invalidate(monthlyReminderEnabledProvider);
            },
          ),
        ],
      ),
    );
  }
}
