import 'package:deduzai/app/widgets/custom_bottom_bar.dart';
import 'package:deduzai/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/summary')) return 1;
    if (location.startsWith('/tips')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/expenses');
      case 1:
        context.go('/summary');
      case 2:
        context.go('/tips');
      case 3:
        context.go('/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/new'),
        backgroundColor: AppColors.secondary,
        foregroundColor: colorScheme.onInverseSurface,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
      ),
    );
  }
}
