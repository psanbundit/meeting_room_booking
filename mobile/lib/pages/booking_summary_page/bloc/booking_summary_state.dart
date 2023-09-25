import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/models/response.dart';
import 'package:meeting_room_booking/models/room.dart';

class BookingSummaryState extends Equatable {
  final TimeOfDay? endTime;
  final Room? room;
  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final String? message;
  final int? code;
  final ResponseStatus? status;

  const BookingSummaryState({
    this.endTime,
    this.room,
    this.selectedDate,
    this.startTime,
    this.message,
    this.code,
    this.status = ResponseStatus.init,
  });

  BookingSummaryState copyWith({
    TimeOfDay? endTime,
    Room? room,
    DateTime? selectedDate,
    TimeOfDay? startTime,
    String? message,
    int? code,
    ResponseStatus? status,
  }) {
    return BookingSummaryState(
        endTime: endTime ?? this.endTime,
        room: room ?? this.room,
        selectedDate: selectedDate ?? this.selectedDate,
        startTime: startTime ?? this.startTime,
        message: message ?? this.message,
        code: code ?? this.code,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        endTime,
        room,
        selectedDate,
        startTime,
        message,
        code,
        status,
      ];
}
