import 'package:deduzai/app/app.dart';
import 'package:deduzai/core/database/providers/database_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_database.dart';

void main() {
  testWidgets('App renders with bottom navigation', (tester) async {
    final db = createTestDatabase();
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const DeduzAiApp(),
      ),
    );
    // Pump once to get past loading state; avoid pumpAndSettle with infinite streams
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Resumo'), findsOneWidget);
    expect(find.text('Config'), findsOneWidget);
  });
}
