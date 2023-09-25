import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/page/booking_summary_page.dart';
import 'package:meeting_room_booking/pages/dashboard_page/page/dashboard_page.dart';
import 'package:meeting_room_booking/pages/landing_page/page/landing_page.dart';
import 'package:meeting_room_booking/pages/search_room/page/search_room_page.dart';

enum RouteName {
  splashScreenPage('/splash_screen'),
  landingPage('/'),
  dashboardPage('/dashboard'),
  myBookingsPage('/my_bookings'),
  searchRoomPage('/search_room'),
  bookingSummaryPage('/booking_summary'),
  bookingResultPage('/booking_result');

  String get name {
    switch (this) {
      case RouteName.splashScreenPage:
        return 'splash screen page';
      case RouteName.landingPage:
        return 'landing page';
      case RouteName.dashboardPage:
        return 'dashboard page';
      case RouteName.myBookingsPage:
        return 'my bookings page';
      case RouteName.searchRoomPage:
        return 'search room page';
      case RouteName.bookingSummaryPage:
        return 'booking summary page';
      case RouteName.bookingResultPage:
        return 'booking result page';
      default:
        return '';
    }
  }

  final String path;

  const RouteName(this.path);
}

class Routes {
  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteName.splashScreenPage.path,
    routes: <RouteBase>[
      GoRoute(
        name: RouteName.splashScreenPage.name,
        path: RouteName.splashScreenPage.path,
        pageBuilder: (context, state) {
          return buildPage(
            key: state.pageKey,
            child: const MeetingRoomLandingPage(),
            arguments: state.extra,
          );
        },
      ),
      GoRoute(
        name: RouteName.landingPage.name,
        path: RouteName.landingPage.path,
        pageBuilder: (context, state) {
          return buildPage(
            key: state.pageKey,
            child: const MeetingRoomLandingPage(),
            arguments: state.extra,
          );
        },
      ),
      GoRoute(
        name: RouteName.dashboardPage.name,
        path: RouteName.dashboardPage.path,
        pageBuilder: (context, state) {
          return buildPage(
            key: state.pageKey,
            child: const DashBoardPage(),
            arguments: state.extra,
          );
        },
      ),
      GoRoute(
        name: RouteName.searchRoomPage.name,
        path: RouteName.searchRoomPage.path,
        pageBuilder: (context, state) {
          return buildPage(
            key: state.pageKey,
            child: const SearchRoomPage(),
            arguments: state.extra,
          );
        },
      ),
      GoRoute(
        name: RouteName.bookingSummaryPage.name,
        path: RouteName.bookingSummaryPage.path,
        pageBuilder: (context, state) {
          BookingSummaryPageAgruments extra =
              state.extra as BookingSummaryPageAgruments;
          return buildPage(
            key: state.pageKey,
            child: BookingSummaryPage(args: extra),
            arguments: extra,
          );
        },
      )
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
