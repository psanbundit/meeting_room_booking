import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/common/date_selector.dart';
import 'package:meeting_room_booking/common/room_list.dart';
import 'package:meeting_room_booking/models/response.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/page/booking_summary_page.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_cubit.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_state.dart';
import 'package:meeting_room_booking/routes.dart';
import 'package:meeting_room_booking/utils/time.dart';

class SearchRoomPage extends StatefulWidget {
  const SearchRoomPage({super.key});

  @override
  State<SearchRoomPage> createState() => _SearchRoomPageState();
}

class _SearchRoomPageState extends State<SearchRoomPage> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchRoomPageCubit>().resetState();
      DateTime dayNow = DateTime.now();
      TimeOfDay timeNow = TimeOfDay.now();
      context.read<SearchRoomPageCubit>().setSelectedDate(dayNow);
      context.read<SearchRoomPageCubit>().setStartTime(timeNow);
      context.read<SearchRoomPageCubit>().setEndTime(
          TimeOfDay(hour: timeNow.hour + 1, minute: timeNow.minute));
      context.read<SearchRoomPageCubit>().checkIsSearchValid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MeetingRoomAppBar(),
      body: MeetingRoomBody(),
    );
  }
}

class MeetingRoomAppBar extends StatelessWidget with PreferredSizeWidget {
  const MeetingRoomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(124);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color(0xff191919),
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/background/pawel-chu-ULh0i2txBCY-unsplash-1.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(79, 0, 0, 0), BlendMode.srcOver)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(72, 39, 39, 39),
              spreadRadius: 0,
              blurRadius: 10.0,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),

                  // IconButton(onPressed: (){}, icon: icon)
                ],
              ),
              const Text("Select Meeting Room",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
            ],
          ),
        ));
  }
}

class MeetingRoomBody extends StatefulWidget {
  const MeetingRoomBody({super.key});

  @override
  State<StatefulWidget> createState() => _MeetingRoomBody();
}

class _MeetingRoomBody extends State<MeetingRoomBody> {
  final dio = Dio();

  void onClickSearchButton() {
    getAllRoom();
  }

  Future<void> getAllRoom() async {
    try {
      await context.read<SearchRoomPageCubit>().getAllRoom();
    } catch (e) {
      if (kDebugMode) {
        print("> error: $e");
      }
      // Handle the error here. You can show an error message or take appropriate action.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BlocBuilder<SearchRoomPageCubit, SearchRoomPageState>(
              builder: (context, state) => MeetingRoomDateSelector(
                  selectedDate: state.selectedDate,
                  startTime: state.startTime,
                  endTime: state.endTime,
                  onChangeDate: (date, start, end) => {
                        context
                            .read<SearchRoomPageCubit>()
                            .setFormSearch(date, start, end)
                      }),
            ),
            BlocSelector<SearchRoomPageCubit, SearchRoomPageState, bool>(
                selector: (state) => state.isSearchValid,
                builder: (context, isSearchValid) =>
                    BlocListener<SearchRoomPageCubit, SearchRoomPageState>(
                      listener: (context, state) => {
                        if (state.status == ResponseStatus.fail)
                          {
                            context.read<SearchRoomPageCubit>().resetSearch(),
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const SingleChildScrollView(
                                    child: Text(
                                        "Oops, searching problem has occured. Please try again later."),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () => {context.pop(true)},
                                    ),
                                  ],
                                );
                              },
                            )
                          }
                      },
                      child: ElevatedButton(
                        onPressed: isSearchValid ? onClickSearchButton : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSearchValid
                              ? const Color(0xff5cc99b)
                              : Colors.grey,
                          fixedSize: const Size.fromHeight(50),
                        ),
                        child: const Text("Search",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SearchRoomPageCubit, SearchRoomPageState>(
                builder: (context, state) => RoomList(
                    roomList: state.roomList ?? [],
                    onTapItem: (room) {
                      context.pushNamed(RouteName.bookingSummaryPage.name,
                          extra: BookingSummaryPageAgruments(
                            roomId: room.id ?? 0,
                            selectedDate: state.selectedDate ?? DateTime.now(),
                            startTime: state.startTime ?? TimeOfDay.now(),
                            endTime: state.endTime ?? TimeOfDay.now(),
                          ));
                    })),
          ]),
    );
  }
}

class MeetingRoomDateSelector extends StatefulWidget {
  MeetingRoomDateSelector(
      {super.key,
      required this.selectedDate,
      required this.startTime,
      required this.endTime,
      required this.onChangeDate});

  TimeOfDay? endTime;
  DateTime? selectedDate;
  TimeOfDay? startTime;

  @override
  _MeetingRoomDateSelector createState() => _MeetingRoomDateSelector();

  Function(DateTime? selectedDate, TimeOfDay? startTime, TimeOfDay? endTime)?
      onChangeDate;
}

class _MeetingRoomDateSelector extends State<MeetingRoomDateSelector> {
  Future<void> _onClickDateSelector(BuildContext context) async {
    if (widget.selectedDate == null) return;
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.selectedDate!,
        firstDate: now,
        lastDate: now.add(const Duration(days: 365)));

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
        if (widget.onChangeDate != null) {
          widget.onChangeDate!(
              widget.selectedDate, widget.startTime, widget.endTime);
        }
      });
    }
  }

  Future<void> _onClickTimeRangeSelector(
      BuildContext context, String action) async {
    if (widget.selectedDate == null) return;
    final TimeOfDay now = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: now,
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        if (action == 'start') {
          widget.startTime = picked;
        } else if (action == 'end') {
          widget.endTime = picked;
        }
        if (widget.onChangeDate != null) {
          widget.onChangeDate!(
              widget.selectedDate, widget.startTime, widget.endTime);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DateSelector(
          title: "Date",
          value: widget.selectedDate != null
              ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
              : '--/--/--',
          onPressed: () => _onClickDateSelector(context),
        ),
        const SizedBox(
          height: 20,
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: DateSelector(
                  title: "Start Time",
                  value: widget.startTime != null
                      ? TimeUtils().formatTimeOfDay(widget.startTime!)
                      : '00:00',
                  onPressed: () => _onClickTimeRangeSelector(context, 'start')),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: DateSelector(
                  title: "End Time",
                  value: widget.endTime != null
                      ? TimeUtils().formatTimeOfDay(widget.endTime!)
                      : '00:00',
                  onPressed: () => _onClickTimeRangeSelector(context, 'end')),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
