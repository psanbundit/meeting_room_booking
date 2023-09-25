import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_state.dart';

class SearchRoomPageCubit extends Cubit<SearchRoomPageState> {
  SearchRoomPageCubit() : super(const SearchRoomPageState());

  Dio dio = Dio();

  void setSelectedDate(DateTime selectedDate) {
    emit(state.copyWith(
      selectedDate: selectedDate,
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

  void setRoomList(List<Room> list) {
    emit(state.copyWith(
      roomList: list,
    ));
  }

  void checkIsSearchValid() {
    emit(state.copyWith(
      isSearchValid: isSearchDataValid(),
    ));
  }

  void setFormSearch(
      DateTime? selectedDate, TimeOfDay? startTime, TimeOfDay? endTime) {
    emit(state.copyWith(
        selectedDate: selectedDate,
        startTime: startTime,
        endTime: endTime,
        isSearchValid: isSearchDataValid()));
  }

  double timeToDouble(TimeOfDay time) => time.hour + time.minute / 60.0;

  bool isSearchDataValid() {
    if (state.startTime == null ||
        state.endTime == null ||
        state.selectedDate == null) {
      return false;
    }
    if (timeToDouble(state.startTime!) > timeToDouble(state.endTime!)) {
      return false;
    }
    return true;
  }

  Future<void> getAllMeetingRooms() async {
    DateTime _pickedStartTime = DateTime(
      state.selectedDate!.year,
      state.selectedDate!.month,
      state.selectedDate!.day,
      state.startTime!.hour,
      state.startTime!.minute,
    );

    DateTime _pickedEndTime = DateTime(
      state.selectedDate!.year,
      state.selectedDate!.month,
      state.selectedDate!.day,
      state.endTime!.hour,
      state.endTime!.minute,
    );

    emit(state.copyWith(
      roomList: [],
      status: SearchRoomStatus.init,
    ));

    try {
      Response response =
          await dio.get('http://localhost:8080/rooms', queryParameters: {
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

  Future<void> getAllRoom() async {
    try {
      if (!isSearchDataValid()) throw Exception("Invalid search data");
      final start = DateTime(
              state.selectedDate!.year,
              state.selectedDate!.month,
              state.selectedDate!.day,
              state.startTime!.hour,
              state.startTime!.minute)
          .toIso8601String();
      final end = DateTime(
              state.selectedDate!.year,
              state.selectedDate!.month,
              state.selectedDate!.day,
              state.endTime!.hour,
              state.endTime!.minute)
          .toIso8601String();
      Response response = await dio.get(
        'http://localhost:8080/room/available',
        queryParameters: {
          'startTime': start,
          'endTime': end,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List list = data['data'];
        List<Room> roomList = [];
        for (var data in list) {
          Room room = Room.fromJson(data);
          roomList.add(room);
        }
        emit(state.copyWith(
          roomList: roomList,
          status: SearchRoomStatus.sucess,
        ));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: SearchRoomStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: SearchRoomStatus.fail,
        code: 400,
        message: e.toString(),
      ));
    }
  }
}
