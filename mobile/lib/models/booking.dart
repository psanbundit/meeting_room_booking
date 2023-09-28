import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/models/user.dart';

class Booking {
  int? id;
  String? start;
  String? end;
  String? createdAt;
  int? nbPeople;
  User? user;
  Room? room;
  String? status;

  Booking(
      {this.id,
      this.start,
      this.end,
      this.createdAt,
      this.nbPeople,
      this.user,
      this.room,
      this.status});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    createdAt = json['createdAt'];
    nbPeople = json['nbPeople'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['start'] = start;
    data['end'] = end;
    data['createdAt'] = createdAt;
    data['nbPeople'] = nbPeople;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (room != null) {
      data['room'] = room!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

enum BookingStatus {
  reserved('RESERVED'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

  final String value;

  const BookingStatus(this.value);
}
