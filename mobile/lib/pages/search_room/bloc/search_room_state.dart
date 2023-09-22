import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/models/room.dart';

class SearchRoomPageState extends Equatable {
  final DateTime? pickedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  final List<Room>? roomList;

  final String? message;
  final int? code;
  final SearchRoomStatus? status;

  const SearchRoomPageState({
    this.pickedDate,
    this.startTime,
    this.endTime,
    this.roomList = const [],
    this.message,
    this.code,
    this.status = SearchRoomStatus.init,
  });

  SearchRoomPageState copyWith({
    DateTime? pickedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<Room>? roomList,
    String? message,
    int? code,
    SearchRoomStatus? status,
  }) {
    return SearchRoomPageState(
      pickedDate: pickedDate ?? this.pickedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      roomList: roomList ?? this.roomList,
      code: code ?? this.code,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        pickedDate,
        startTime,
        endTime,
        roomList,
        code,
        message,
        status
      ];
}

enum SearchRoomStatus {
  init,
  sucess,
  fail,
}
