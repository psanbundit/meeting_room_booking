import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/common/date_selector.dart';
import 'package:meeting_room_booking/common/room_list_item.dart';
import 'package:meeting_room_booking/common/transition/slide_from_bottom.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/bloc/booking_summary_cubit.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/bloc/booking_summary_state.dart';
import 'package:meeting_room_booking/routes.dart';
import 'package:meeting_room_booking/utils/time.dart';

class BookingSummaryPageAgruments {
  BookingSummaryPageAgruments(
      {this.roomId = 0,
      required this.selectedDate,
      this.startTime = const TimeOfDay(hour: 0, minute: 0),
      this.endTime = const TimeOfDay(hour: 0, minute: 0)});

  TimeOfDay endTime;
  int roomId;
  DateTime selectedDate;
  TimeOfDay startTime;
}

class BookingSummaryPage extends StatefulWidget {
  final BookingSummaryPageAgruments? args;

  const BookingSummaryPage({
    super.key,
    this.args,
  });

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends State<BookingSummaryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.args == null) return;
      final args = widget.args!;
      context
          .read<BookingSummaryCubit>()
          .setBookingState(args.selectedDate, args.startTime, args.endTime);
      context.read<BookingSummaryCubit>().getRoomById(args.roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BookingSummaryBody(),
    );
  }
}

class BookingSummaryBody extends StatelessWidget {
  const BookingSummaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background/damir-kopezhanov-VM1Voswbs0A-unsplash-1.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Flex(direction: Axis.horizontal, children: [
              InkWell(
                  onTap: () => context.pop(true),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              const SizedBox(width: 10),
              const Text("Booking\nSummary",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )),
            ])),
        const Align(
          alignment: Alignment.bottomCenter,
          child: BookingSummaryContent(),
        )
      ],
    );
  }
}

class BookingSummaryContent extends StatefulWidget {
  const BookingSummaryContent({
    super.key,
  });
  @override
  State<BookingSummaryContent> createState() => _BookingSummaryContentState();
}

class _BookingSummaryContentState extends State<BookingSummaryContent> {
  void onPressedConfirm() {
    context.push(RouteName.bookingResultPage.path);
  }

  @override
  Widget build(BuildContext context) {
    return SlideFromBottomTransition(
        child: Column(children: [
      const Spacer(),
      BlocBuilder<BookingSummaryCubit, BookingSummaryState>(
          builder: (context, state) => state.room == null ||
                  state.selectedDate == null ||
                  state.startTime == null ||
                  state.endTime == null
              ? Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(22, 40, 22, 40),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Something went wrong please try again."),
                        const SizedBox(height: 20),
                        OutlinedButton(
                            onPressed: () => context.pop(true),
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size.fromHeight(75),
                              foregroundColor: const Color(0xff5cc99b),
                              side: const BorderSide(color: Color(0xff5cc99b)),
                            ),
                            child: const Text(
                              "Cancel",
                              textAlign: TextAlign.center,
                            )),
                      ]))
              : Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.fromLTRB(22, 40, 22, 40),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                              flex: 2,
                              child: DateSelector(
                                  title: "Date",
                                  value: DateFormat('dd/MM/yyyy')
                                      .format(state.selectedDate!))),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: DateSelector(
                                title: "Time",
                                value:
                                    "${TimeUtils().formatTimeOfDay(state.startTime!)} - ${TimeUtils().formatTimeOfDay(state.endTime!)}"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Selected room",
                            style: TextStyle(
                              fontFamily: 'Monsterrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RoomListItem(room: state.room!)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                              onPressed: () => context.pop(true),
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size.fromHeight(75),
                                foregroundColor: const Color(0xff5cc99b),
                                side:
                                    const BorderSide(color: Color(0xff5cc99b)),
                              ),
                              child: const Text("Cancel")),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: onPressedConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff5cc99b),
                                fixedSize: const Size.fromHeight(75),
                              ),
                              child: const Text("Confirm Booking",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 136, 65, 65)))),
                        ],
                      )
                    ],
                  ),
                )),
    ]));
  }
}
