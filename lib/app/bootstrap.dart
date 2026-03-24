import 'package:deduzai/app/app.dart';
import 'package:deduzai/app/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = FlavorConfig.fromFlavor(flavor);

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
