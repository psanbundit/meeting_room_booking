import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/controller/detail_page_controller.dart';
import 'package:meeting_room_booking/model/room.dart';

class MeetingRoomDetailPage extends StatefulWidget {
  const MeetingRoomDetailPage({
    super.key,
  });

  @override
  State<MeetingRoomDetailPage> createState() => _MeetingRoomDetailPageState();
}

class _MeetingRoomDetailPageState extends State<MeetingRoomDetailPage> {
  Room? roomDetail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map<String, dynamic>? data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      await DetailPageController().getMeetingRoom(data?['id']).then((_roomDetail) {
        setState(() {
          roomDetail = _roomDetail;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomDetail?.name ?? '-'),
      ),
    );
  }
}
