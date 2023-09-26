import 'package:equatable/equatable.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/models/response.dart';

class MyBookingState extends Equatable {
  final List<Booking> bookingList;
  final String? message;
  final ResponseStatus? status;
  final int? code;

  const MyBookingState({
    this.message,
    this.code,
    this.status = ResponseStatus.init,
    this.bookingList = const [],
  });

  MyBookingState copyWith({
    List<Booking>? bookingList,
    String? message,
    int? code,
    ResponseStatus? status,
  }) {
    return MyBookingState(
        message: message ?? this.message,
        code: code ?? this.code,
        status: status ?? this.status,
        bookingList: bookingList ?? this.bookingList);
  }

  @override
  List<Object?> get props => [
        bookingList,
        message,
        code,
        status,
      ];
}
