import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/models/response.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  MyBookingCubit() : super(const MyBookingState());
  final Dio dio = Dio();

  void setBookingList(List<Booking> bookingList) {
    final reservedList = bookingList
        .where((booking) => booking.status == BookingStatus.reserved.value)
        .toList();
    final completedList = bookingList
        .where((booking) => booking.status == BookingStatus.completed.value)
        .toList();
    final cancelledList = bookingList
        .where((booking) => booking.status == BookingStatus.cancelled.value)
        .toList();
    emit(state.copyWith(
      bookingList: bookingList,
      reservedList: reservedList,
      completedList: completedList,
      cancelledList: cancelledList,
    ));
  }

  void resetState() {
    emit(const MyBookingState());
  }

  void setStatus(ResponseStatus status) {
    emit(state.copyWith(
      status: ResponseStatus.init,
    ));
  }

  void addBookingListWithBooking(Booking booking) {
    List<Booking> bookingList = state.bookingList;
    bookingList.add(booking);
    emit(state.copyWith(
      bookingList: bookingList,
    ));
  }

  Future<void> getMyBookings() async {
    try {
      emit(state.copyWith(
        status: ResponseStatus.init,
      ));
      final Response response =
          await dio.get('http://localhost:8080/booking/my', queryParameters: {
        'status': 'ALL',
      });
      List<Booking> bookingList = [];
      if (response.statusCode == 200) {
        bookingList =
            (response.data['data'] as List<dynamic>).map((dynamic item) {
          return Booking.fromJson(item as Map<String, dynamic>);
        }).toList();
        setBookingList(bookingList);
        emit(state.copyWith(
          status: ResponseStatus.success,
        ));
      } else {
        throw Exception("Get my booking fail");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: 400,
        message: e.toString(),
      ));
    }
  }

  Future<void> patchCancelBooking(int id) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        status: ResponseStatus.init,
      ));
      final Response response =
          await dio.patch('http://localhost:8080/booking/$id/cancel');
      if (response.statusCode == 200 && !!response.data['data']) {
        await getMyBookings();
      } else {
        throw Exception("Cancel booking fail at booking id: $id");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
      emit(state.copyWith(
        status: ResponseStatus.fail,
        code: 400,
        message: e.toString(),
      ));
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}
