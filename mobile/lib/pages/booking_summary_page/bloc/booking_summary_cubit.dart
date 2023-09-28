import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/response.dart';
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

  void setBookingId(int? bookingId) {
    emit(state.copyWith(
      bookingId: bookingId,
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

  void resetState(){
    emit(const BookingSummaryState());
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
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.data['errors'],
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: 400,
        message: e.toString(),
      ));
    }
  }

  Future<void> postBookingRoomById() async {
    try {
      emit(state.copyWith(
        isBookingLoading: true,
      ));
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
      // TODO: mockin number of people
      Response response = await dio.post(
        'http://localhost:8080/booking/${state.room!.id}',
        data: FormData.fromMap({
          'nbPeople': 1,
          'start': start,
          'end': end,
        }),
      );
      if (response.statusCode == 201) {
        emit(state.copyWith(
          status: ResponseStatus.sucess,
          bookingId: response.data['data']['id'],
        ));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.data['errors'],
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: 400,
        message: e.toString(),
      ));
    } finally {
      Future.delayed(const Duration(seconds: 3), () {
        emit(state.copyWith(
          isBookingLoading: false,
        ));
      });
    }
  }
}
