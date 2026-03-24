import 'package:deduzai/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders with bottom navigation', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: DeduzAiApp()),
    );
    await tester.pumpAndSettle();

    expect(
      find.byType(NavigationBar),
      findsOneWidget,
    );
    expect(find.text('Resumo'), findsOneWidget);
    expect(find.text('Config'), findsOneWidget);
  });
}
