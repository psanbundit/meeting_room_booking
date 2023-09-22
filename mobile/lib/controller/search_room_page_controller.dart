import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meeting_room_booking/models/room.dart';

class SearchRoomPageController {
  final Dio dio = Dio();

  Future<List<Room>> getAllMeetingRooms({
    required List<Room> roomList,
    required DateTime pickedStartTime,
    required DateTime pickedEndTime,
  }) async {
    try {
      Response response = await dio.get('http://localhost:8080/rooms', queryParameters: {
        "startTime": pickedStartTime.toIso8601String(),
        "endTime": pickedEndTime.toIso8601String(),
      });

      if (response.statusCode == 200) {
        roomList.clear();

        List roomRes = response.data;
        for (var data in roomRes) {
          Room room = Room.fromJson(data);
          roomList.add(room);
        }
      }

      return roomList;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
