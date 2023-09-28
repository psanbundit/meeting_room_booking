import 'package:equatable/equatable.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/models/response.dart';

class MyBookingState extends Equatable {
  final List<Booking> bookingList;
  final List<Booking> reservedList;
  final List<Booking> completedList;
  final List<Booking> cancelledList;
  final String? message;
  final ResponseStatus? status;
  final int? code;
  final bool isLoading;

  const MyBookingState({
    this.message,
    this.code,
    this.status = ResponseStatus.init,
    this.bookingList = const [],
    this.reservedList = const [],
    this.completedList = const [],
    this.cancelledList = const [],
    this.isLoading = false,
  });

  MyBookingState copyWith({
    List<Booking>? bookingList,
    List<Booking>? reservedList,
    List<Booking>? completedList,
    List<Booking>? cancelledList,
    String? message,
    int? code,
    ResponseStatus? status,
    bool? isLoading,
  }) {
    return MyBookingState(
      message: message ?? this.message,
      code: code ?? this.code,
      status: status ?? this.status,
      bookingList: bookingList ?? this.bookingList,
      reservedList: reservedList ?? this.reservedList,
      completedList: completedList ?? this.completedList,
      cancelledList: cancelledList ?? this.cancelledList,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        bookingList,
        reservedList,
        completedList,
        cancelledList,
        message,
        code,
        status,
        isLoading,
      ];
}
