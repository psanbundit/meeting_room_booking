import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  MyBookingCubit() : super(const MyBookingState());
  final Dio dio = Dio();

  void setBookingList(List<Booking> bookingList) {
    emit(state.copyWith(
      bookingList: bookingList,
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
      }
    } catch (e) {
      if (kDebugMode) {
        print("error > $e");
      }
    }
  }
}
