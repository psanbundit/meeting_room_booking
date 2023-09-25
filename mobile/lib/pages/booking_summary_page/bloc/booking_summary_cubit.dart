import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/bloc/booking_summary_state.dart';

class BookingSummaryCubit extends Cubit<BookingSummaryState> {
  BookingSummaryCubit() : super(const BookingSummaryState());

  final Dio dio = Dio();

  void setRoom(Room? room) {
    emit(state.copyWith(
      room: room,
    ));
  }

  void setEndTime(TimeOfDay? endTime) {
    emit(state.copyWith(
      endTime: endTime,
    ));
  }

  void setStartTime(TimeOfDay? startTime) {
    emit(state.copyWith(
      startTime: startTime,
    ));
  }

  void setSelectedDate(DateTime? selectedDate) {
    emit(state.copyWith(
      selectedDate: selectedDate,
    ));
  }

  void setBookingState(
    DateTime selectedDate,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    emit(state.copyWith(
      selectedDate: selectedDate,
      startTime: startTime,
      endTime: endTime,
    ));
  }

  Future<void> getRoomById(int id) async {
    try {
      Response response = await dio.get('http://localhost:8080/room/$id');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        setRoom(Room.fromJson(data));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
