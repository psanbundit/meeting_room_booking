import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_room_booking/common/booking_app_bar.dart';
import 'package:meeting_room_booking/common/booking_card.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_cubit.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_state.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyBookingCubit>().getMyBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookingAppBar(
        imgSrc:
            'assets/images/background/group-business-people-having-meeting-1.png',
        title: "My Bookings",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.account_circle,
                        color: Colors.white, size: 30)),
                // IconButton(onPressed: (){}, icon: icon)
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<MyBookingCubit, MyBookingState>(
              builder: (context, state) => Padding(
                    padding: const EdgeInsets.fromLTRB(22, 30, 22, 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Reserved",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 10),
                              Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 100),
                                  child: BookingCardList(
                                      bookingList: state.reservedList,
                                      variant: BookingStatus.reserved)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Cancelled",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 10),
                              Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 100),
                                  child: BookingCardList(
                                      bookingList: state.cancelledList,
                                      variant: BookingStatus.cancelled)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Completed",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 10),
                              Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 100),
                                  child: BookingCardList(
                                      bookingList: state.completedList,
                                      variant: BookingStatus.completed)),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ]),
                  ))),
    );
  }
}

class BookingCardList extends StatelessWidget {
  const BookingCardList(
      {super.key,
      this.bookingList = const [],
      this.onTapListItem,
      required this.variant});

  final Function()? onTapListItem;
  final List<Booking> bookingList;
  final BookingStatus variant;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: bookingList
            .map((booking) => Column(
                  children: [
                    BookingCard(booking: booking, variant: variant),
                    const SizedBox(height: 10)
                  ],
                ))
            .toList());
  }
}
