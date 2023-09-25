import 'package:flutter/material.dart';
import 'package:meeting_room_booking/common/room_list_item.dart';
import 'package:meeting_room_booking/models/room.dart';


class RoomList extends StatelessWidget {
  RoomList({
    super.key,
    this.roomList = const [],
    this.onTapItem,
  });

  List<Room> roomList;

  Function(Room room)? onTapItem;

  void onTapListItem(BuildContext context, Room room) {
    if (onTapItem != null) onTapItem!(room);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text("Available Room",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
        const SizedBox(height: 10),
        Expanded(
            child: ListView.separated(
          itemCount: roomList.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                RoomListItem(room: roomList[index], onTap: onTapListItem),
              ],
            );
          },
        ))
      ],
    ));
  }
}
