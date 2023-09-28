import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/common/booking_app_bar.dart';
import 'package:meeting_room_booking/common/booking_card.dart';
import 'package:meeting_room_booking/common/transition/slide_from_bottom.dart';
import 'package:meeting_room_booking/models/booking.dart';
import 'package:meeting_room_booking/models/response.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_cubit.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_state.dart';
import 'package:meeting_room_booking/routes.dart';

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
      context.read<MyBookingCubit>().resetState();
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
      body: Stack(children: [
        SingleChildScrollView(
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
                                        variant: BookingStatus.reserved,
                                        onPressedCancel: (Booking booking) {
                                          if (booking.id == null) {
                                            context
                                                .read<MyBookingCubit>()
                                                .setStatus(ResponseStatus.fail);
                                            return;
                                          }
                                          context
                                              .read<MyBookingCubit>()
                                              .patchCancelBooking(booking.id!);
                                        })),
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
                            const SizedBox(height: 155),
                            BlocListener<MyBookingCubit, MyBookingState>(
                                listenWhen: (previous, current) =>
                                    previous.isLoading != current.isLoading,
                                listener: (context, state) => {
                                      if (state.isLoading &&
                                          state.status == ResponseStatus.init)
                                        {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      CircularProgressIndicator(),
                                                      SizedBox(width: 20),
                                                      Text("Loading..."),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        }
                                      else if (!state.isLoading)
                                        {
                                          Future.delayed(
                                              const Duration(seconds: 2), () {
                                            context.pop();
                                          })
                                        }
                                    },
                                child: Container())
                          ]),
                    ))),
        Align(
          alignment: Alignment.bottomCenter,
          child: SlideFromBottomTransition(
              child: Container(
                  width: double.infinity,
                  height: 155,
                  padding: const EdgeInsets.fromLTRB(22, 50, 22, 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(72, 39, 39, 39),
                        spreadRadius: 0,
                        blurRadius: 10.0,
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: this is weird should improve
                      context.go(RouteName.landingPage.path);
                      context.push(RouteName.dashboardPage.path);
                      context.push(RouteName.searchRoomPage.path);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff5cc99b))),
                    child: const Text(
                      "Make New Booking",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))),
        ),
      ]),
    );
  }
}

class BookingCardList extends StatelessWidget {
  const BookingCardList(
      {super.key,
      this.bookingList = const [],
      this.onTapListItem,
      required this.variant,
      this.onPressedCancel});

  final Function()? onTapListItem;
  final Function(Booking booking)? onPressedCancel;
  final List<Booking> bookingList;
  final BookingStatus variant;

  @override
  Widget build(BuildContext context) {
    return bookingList.isNotEmpty
        ? Column(
            children: bookingList
                .map((booking) => Column(
                      children: [
                        BookingCard(
                          booking: booking,
                          variant: variant,
                          onPressedCancel: onPressedCancel,
                        ),
                        const SizedBox(height: 10)
                      ],
                    ))
                .toList())
        : SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("No booking in the list", textAlign: TextAlign.center)
              ],
            ));
  }
}
