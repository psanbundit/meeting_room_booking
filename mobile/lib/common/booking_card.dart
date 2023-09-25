import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({super.key});

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
              Text("Booking No. ${1}"),
              SizedBox(height: 24),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Room ${'A0001'}"),
                  Text("${25} Guests max"),
                ],
              ),
              SizedBox(height: 12),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Room ${'A0001'}"),
                  Text("${25} Guests max"),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "${'Cancel'}",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)))
            ]));
  }
}
