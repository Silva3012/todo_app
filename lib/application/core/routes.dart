import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/app/presentation/pages/home/home_page.dart';
import 'package:todo_app/application/app/presentation/pages/settings/settings_page.dart';
import 'package:todo_app/application/app/presentation/pages/task/task_page.dart';
import 'package:todo_app/application/core/go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home/dashboard',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/home/:tab',
            builder: (context, state) => HomePage(
              key: state.pageKey,
              tab: state.pathParameters['tab'] ?? 'dashboard',
            ),
          ),
          GoRoute(
            path: '/home/task',
            builder: (context, state) {
              return const TaskPage();
            },
          ),
        ])
  ],
);
