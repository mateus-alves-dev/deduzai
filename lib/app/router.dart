import 'package:deduzai/app/app_shell.dart';
import 'package:deduzai/features/annual_summary/presentation/screens/annual_summary_screen.dart';
import 'package:deduzai/features/expense_entry/presentation/screens/camera_capture_screen.dart';
import 'package:deduzai/features/expense_entry/presentation/screens/expense_form_screen.dart';
import 'package:deduzai/features/expense_list/presentation/screens/expense_list_screen.dart';
import 'package:deduzai/features/receipt_gallery/presentation/screens/archived_receipts_screen.dart';
import 'package:deduzai/features/receipt_gallery/presentation/screens/receipt_viewer_screen.dart';
import 'package:deduzai/features/recurring_expenses/presentation/screens/recurring_expense_form_screen.dart';
import 'package:deduzai/features/recurring_expenses/presentation/screens/recurring_expenses_screen.dart';
import 'package:deduzai/features/search/presentation/screens/search_screen.dart';
import 'package:deduzai/features/settings/presentation/screens/settings_screen.dart';
import 'package:deduzai/features/tips/presentation/screens/tips_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/expenses',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/expenses',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ExpenseListScreen(),
          ),
          routes: [
            GoRoute(
              path: 'new',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) =>
                  const ExpenseFormScreen(),
            ),
            GoRoute(
              path: ':id',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => ExpenseFormScreen(
                expenseId: state.pathParameters['id'],
              ),
              routes: [
                GoRoute(
                  path: 'receipt',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => ReceiptViewerScreen(
                    expenseId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/summary',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AnnualSummaryScreen(),
          ),
        ),
        GoRoute(
          path: '/tips',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TipsScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/camera',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => const MaterialPage(
        fullscreenDialog: true,
        child: CameraCaptureScreen(),
      ),
    ),
    GoRoute(
      path: '/receipts/archived',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ArchivedReceiptsScreen(),
    ),
    GoRoute(
      path: '/recurring',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RecurringExpensesScreen(),
      routes: [
        GoRoute(
          path: 'new',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const RecurringExpenseFormScreen(),
        ),
        GoRoute(
          path: ':id',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => RecurringExpenseFormScreen(
            recurringId: state.pathParameters['id'],
          ),
        ),
      ],
    ),
  ],
);
