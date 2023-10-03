import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/routes.dart';

class BookingResultPageAgruments {
  final int bookingId;

  const BookingResultPageAgruments({
    required this.bookingId,
  });
}

class BookingResultPage extends StatefulWidget {
  const BookingResultPage({super.key, required this.args});

  final BookingResultPageAgruments args;

  @override
  State<BookingResultPage> createState() => _BookingResultPageState();
}

class _BookingResultPageState extends State<BookingResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("booking_result_page"),
      body: BookingResultBody(id: widget.args.bookingId),
    );
  }
}

class BookingResultBody extends StatelessWidget {
  const BookingResultBody({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/background/damir-kopezhanov-VM1Voswbs0A-unsplash-1.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
            width: double.infinity,
            child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: () {
                          // TODO: this is weird should improve
                          context.go(RouteName.landingPage.path);
                          context.push(RouteName.dashboardPage.path);
                          context.push(RouteName.searchRoomPage.path);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Flex(direction: Axis.vertical, children: [
                      const Text("Booking\nSuccessful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 28),
                      Text("Your Booking No. is $id",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ))
                    ]),
                  ),
                  const Spacer(),
                ])),
      )
    ]);
  }
}
