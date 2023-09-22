import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:meeting_room_booking/meeting_room_booking_roots.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  final args = <String, dynamic>{};

  Logger.init(
    kDebugMode,
    isShowNavigation: false,
  );

  runApp(MeetingRoomBookingRoots(args: args));
}
