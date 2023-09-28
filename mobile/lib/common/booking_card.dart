import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/models/booking.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key, required this.booking, required this.variant});

  final Booking booking;
  final BookingStatus variant;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(30, 24, 20, 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1)),
        child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Booking No. ${booking.id}"),
              const SizedBox(height: 24),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Room ${booking.room?.name ?? '-'}"),
                  Text("${booking.room?.capacity ?? 0} Guests max"),
                ],
              ),
              const SizedBox(height: 12),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(booking.start ?? ''))),
                  Text(
                      "${DateFormat('hh:mm aaa').format(DateTime.parse(booking.start ?? ''))} - ${DateFormat('hh:mm aaa').format(DateTime.parse(booking.end ?? ''))}"),
                ],
              ),
              const SizedBox(height: 24),
              booking.status == BookingStatus.reserved.value
                  ? ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(),
            ]));
  }
}
