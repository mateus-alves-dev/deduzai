import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:deduzai/core/theme/app_spacing.dart';
import 'package:deduzai/core/theme/app_text_styles.dart';
import 'package:deduzai/core/widgets/deduzai_app_bar.dart';
import 'package:deduzai/features/notifications/data/notification_service.dart';
import 'package:deduzai/features/notifications/domain/notification_scheduler.dart';
import 'package:deduzai/features/notifications/presentation/providers/notification_providers.dart';
import 'package:deduzai/features/settings/presentation/providers/app_info_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequencyAsync = ref.watch(reminderFrequencyProvider);
    final timeOfDayAsync = ref.watch(reminderTimeOfDayProvider);

    final frequency =
        frequencyAsync.value ?? ReminderFrequency.monthly;
    final timeOfDay =
        timeOfDayAsync.value ?? ReminderTimeOfDay.morning;

    return Scaffold(
      appBar: const DeduzaiAppBar(title: 'Configurações'),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _SectionHeader('Notificações'),
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Lembretes',
                        style: AppTextStyles.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Frequency label
                  Text(
                    'Frequência',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Frequency segmented button
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<ReminderFrequency>(
                      segments: ReminderFrequency.values
                          .map(
                            (f) => ButtonSegment(
                              value: f,
                              label: Text(f.label),
                            ),
                          )
                          .toList(),
                      selected: {frequency},
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        textStyle: WidgetStateProperty.all(
                          AppTextStyles.labelMedium,
                        ),
                      ),
                      onSelectionChanged: (selected) async {
                        final newFrequency = selected.first;
                        final dao = ref.read(appSettingsDaoProvider);
                        await dao.setValue(
                          AppSettingsKeys.reminderFrequency,
                          newFrequency.name,
                        );
                        await ref
                            .read(notificationSchedulerProvider)
                            .scheduleAll();
                        ref.invalidate(reminderFrequencyProvider);
                      },
                    ),
                  ),

                  // Debug: test notification (dev only)
                  if (kDebugMode) ...[
                    const SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonalIcon(
                        icon: const Icon(Icons.bug_report, size: 18),
                        label: const Text('Testar notificação (10s)'),
                        onPressed: () async {
                          final service =
                              ref.read(notificationServiceProvider);
                          final hasPermission =
                              await service.checkPermission();
                          if (!hasPermission) {
                            final granted =
                                await service.requestPermission();
                            if (!granted && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Permissão de notificação negada.',
                                  ),
                                ),
                              );
                              return;
                            }
                          }
                          await service.scheduleMonthlyReminder(
                            DateTime.now()
                                .add(const Duration(seconds: 10)),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Notificação agendada para 10 segundos!',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],

                  // Time of day (hidden when disabled)
                  if (frequency != ReminderFrequency.none) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Horário',
                      style: AppTextStyles.labelMedium.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ReminderTimeOfDay>(
                        segments: ReminderTimeOfDay.values
                            .map(
                              (t) => ButtonSegment(
                                value: t,
                                label: Text(t.label),
                              ),
                            )
                            .toList(),
                        selected: {timeOfDay},
                        showSelectedIcon: false,
                        style: ButtonStyle(
                          textStyle: WidgetStateProperty.all(
                            AppTextStyles.labelMedium,
                          ),
                        ),
                        onSelectionChanged: (selected) async {
                          final newTime = selected.first;
                          final dao = ref.read(appSettingsDaoProvider);
                          await dao.setValue(
                            AppSettingsKeys.reminderTimeOfDay,
                            newTime.name,
                          );
                          await ref
                              .read(notificationSchedulerProvider)
                              .scheduleAll();
                          ref.invalidate(reminderTimeOfDayProvider);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Automação'),
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text('Recorrências'),
              subtitle: const Text('Gerencie gastos que se repetem'),
              trailing: const Icon(Icons.chevron_right),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              onTap: () => context.push('/recurring'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Dados'),
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text('Comprovantes arquivados'),
              subtitle: const Text('Comprovantes de gastos excluídos'),
              trailing: const Icon(Icons.chevron_right),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              onTap: () => context.push('/receipts/archived'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _SectionHeader('Legal'),
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Política de Privacidade'),
                  trailing: const Icon(Icons.chevron_right),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  onTap: () => context.push('/settings/privacy'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Termos de Uso'),
                  trailing: const Icon(Icons.chevron_right),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  onTap: () => context.push('/settings/terms'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _AppInfoFooter(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: Text(
        title,
        style: AppTextStyles.labelMedium.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _AppInfoFooter extends ConsumerWidget {
  const _AppInfoFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionAsync = ref.watch(appVersionProvider);
    final version = versionAsync.value;

    return Column(
      children: [
        Text(
          'DeduzAí',
          style: AppTextStyles.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        if (version != null) ...[
          const SizedBox(height: 2),
          Text(
            'Versão $version',
            style: AppTextStyles.labelMedium.copyWith(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xs),
        Text(
          '© 2026 DeduzAí',
          style: AppTextStyles.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ],
    );
  }
}
