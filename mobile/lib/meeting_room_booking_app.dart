import 'package:flutter/material.dart';
import 'package:meeting_room_booking/page/landing_page.dart';

class MeetingRoomBookingApp extends StatelessWidget {
  const MeetingRoomBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palo IT Meeting Room Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5CC99B),
      ),
      home: const MeetingRoomLandingPage(),
    );
  }
}
