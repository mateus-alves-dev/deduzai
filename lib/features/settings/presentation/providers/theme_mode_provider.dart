import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:deduzai/core/database/tables/app_settings_table.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ThemeMode> themeMode(Ref ref) async {
  final dao = ref.watch(appSettingsDaoProvider);
  final raw = await dao.getValue(AppSettingsKeys.themeMode);
  return switch (raw) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
