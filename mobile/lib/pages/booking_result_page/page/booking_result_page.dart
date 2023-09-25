import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingResultPage extends StatefulWidget {
  const BookingResultPage({super.key});

  @override
  State<BookingResultPage> createState() => _BookingResultPageState();
}

class _BookingResultPageState extends State<BookingResultPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BookingResultBody(),
    );
  }
}

class BookingResultBody extends StatelessWidget {
  const BookingResultBody({super.key});

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
                        onTap: () => {
                              context.pop(),
                            },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Flex(direction: Axis.vertical, children: const [
                      Text("Booking\nSuccessful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                      SizedBox(height: 28),
                      Text("Your Booking No. is ${1}",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
