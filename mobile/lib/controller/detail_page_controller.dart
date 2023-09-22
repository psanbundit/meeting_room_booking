import 'package:dio/dio.dart';
import 'package:meeting_room_booking/models/room.dart';

class DetailPageController {
  final Dio dio = Dio();

  Future<Room?> getMeetingRoom(int? id) async {
    Room? roomDetail;

    try {
      Response response = await dio.get('http://localhost:8080/rooms/$id');

      if (response.statusCode == 200) {
        roomDetail = Room.fromJson(response.data);
      }

      return roomDetail;
    } catch (e) {
      rethrow;
    }
  }
}
