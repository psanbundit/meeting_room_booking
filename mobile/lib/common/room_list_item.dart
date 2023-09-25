import 'package:flutter/material.dart';
import 'package:meeting_room_booking/models/room.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({super.key, required this.room, this.onTap});

  final Room room;
  final Function(BuildContext context, Room room)? onTap;

  void onTapCard(BuildContext context) {
    if (onTap == null) return;
    onTap!(context, room);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTapCard(context),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Room ${room.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("${room.capacity} Guests max",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ))));
  }
}
