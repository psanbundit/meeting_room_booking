import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meeting_room_booking/models/response.dart';
import 'package:meeting_room_booking/models/room.dart';

class SearchRoomPageState extends Equatable {
  final DateTime? selectedDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final List<Room>? roomList;
  final String? message;
  final int? code;
  final ResponseStatus? status;
  final bool isSearchValid;

  const SearchRoomPageState({
    this.selectedDate,
    this.startTime,
    this.endTime,
    this.roomList = const [],
    this.message,
    this.code,
    this.status = ResponseStatus.init,
    this.isSearchValid = false,
  });

  SearchRoomPageState copyWith({
    DateTime? selectedDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<Room>? roomList,
    String? message,
    int? code,
    ResponseStatus? status,
    bool? isSearchValid,
  }) {
    return SearchRoomPageState(
      selectedDate: selectedDate ?? this.selectedDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      roomList: roomList ?? this.roomList,
      code: code ?? this.code,
      message: message ?? this.message,
      status: status ?? this.status,
      isSearchValid: isSearchValid ?? this.isSearchValid,
    );
  }

  @override
  List<Object?> get props => [
        selectedDate,
        startTime,
        endTime,
        roomList,
        code,
        message,
        status,
        isSearchValid,
      ];
}

enum SearchRoomStatus {
  init,
  sucess,
  fail,
}
