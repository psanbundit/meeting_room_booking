import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_state.dart';

class SerachRoomPageCubit extends Cubit<SearchRoomPageState> {
  SerachRoomPageCubit() : super(const SearchRoomPageState());

  Dio dio = Dio();

  void setPickDate(DateTime pickedDate) {
    emit(state.copyWith(
      pickedDate: pickedDate,
    ));
  }

  void setStartTime(TimeOfDay startTime) {
    emit(state.copyWith(
      startTime: startTime,
    ));
  }

  void setEndTime(TimeOfDay endTime) {
    emit(state.copyWith(
      endTime: endTime,
    ));
  }

  Future<void> getAllMeetingRooms() async {
    DateTime _pickedStartTime = DateTime(
      state.pickedDate!.year,
      state.pickedDate!.month,
      state.pickedDate!.day,
      state.startTime!.hour,
      state.startTime!.minute,
    );

    DateTime _pickedEndTime = DateTime(
      state.pickedDate!.year,
      state.pickedDate!.month,
      state.pickedDate!.day,
      state.endTime!.hour,
      state.endTime!.minute,
    );

    emit(state.copyWith(
      roomList: [],
      status: SearchRoomStatus.init,
    ));

    try {
      Response response = await dio.get('http://localhost:8080/rooms', queryParameters: {
        "startTime": _pickedStartTime.toIso8601String(),
        "endTime": _pickedEndTime.toIso8601String(),
      });

      List<Room> _roomList = [];

      if (response.statusCode == 200) {
        List roomRes = response.data;
        for (var data in roomRes) {
          Room room = Room.fromJson(data);
          _roomList.add(room);
        }

        emit(state.copyWith(
          roomList: _roomList,
          status: SearchRoomStatus.sucess,
        ));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      emit(state.copyWith(
        status: SearchRoomStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      ));
    }
  }
}
