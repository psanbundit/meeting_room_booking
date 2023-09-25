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
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['createdAt'] = this.createdAt;
    data['nbPeople'] = this.nbPeople;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}