import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        name: RouteName.splashScreenPage.name,
        path: '/',
        pageBuilder: (context, state) {
          return buildPage(
            key: state.pageKey,
            child: const Scaffold(),
            arguments: state.extra,
          );
        },
      ),
    ],
  );
}

MaterialPage<void> buildPage({
  required Widget child,
  LocalKey? key,
  Object? arguments,
  bool disableBack = false,
}) {
  return MaterialPage<void>(
    key: key,
    child: child,
    arguments: arguments,
    fullscreenDialog: disableBack,
  );
}

enum RouteName {
  splashScreenPage,
}

extension RouteNameExtensions on RouteName {
  String get name {
    switch (this) {
      case RouteName.splashScreenPage:
        return 'splash screen page';
      default:
        return '';
    }
  }
}
