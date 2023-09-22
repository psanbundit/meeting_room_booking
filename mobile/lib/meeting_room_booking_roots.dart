import 'package:flutter/material.dart';
import 'package:meeting_room_booking/main/main_app.dart';
import 'package:meeting_room_booking/main/main_injector.dart';
import 'package:meeting_room_booking/main/main_localization.dart';
import 'package:meeting_room_booking/main/main_system.dart';
import 'package:root_dependencies/root_dependencies.dart';

class MeetingRoomBookingRoots extends RootApp {
  MeetingRoomBookingRoots({
    Key? key,
    Map<String, dynamic> args = const {},
  }) : super(
          key: key,
          view: () => const MainApp(),
          loadingView: () => const MaterialApp(
            home: Scaffold(),
          ),
          system: () => MainSystem(),
          blocInjector: MainInjector(),
          localization: MainLocalization(),
          args: () => args,
        );
}
