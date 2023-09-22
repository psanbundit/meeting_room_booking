import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/common/common_app_bar.dart';
import 'package:meeting_room_booking/controller/search_room_page_controller.dart';
import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/pages/detail_page/page/detail_page.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_cubit.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_state.dart';

class SearchRoomPage extends StatefulWidget {
  const SearchRoomPage({super.key});

  @override
  State<SearchRoomPage> createState() => _SearchRoomPageState();
}

class _SearchRoomPageState extends State<SearchRoomPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SerachRoomPageCubit, SearchRoomPageState>(
      listener: (context, state) {
        switch (state.status) {
          case SearchRoomStatus.fail:
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(state.message ?? 'OOPS'),
              ),
            );
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: const MeetRoomAppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date'),
              BlocBuilder<SerachRoomPageCubit, SearchRoomPageState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2023, 12, 31),
                      currentDate: state.pickedDate,
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        context.read<SerachRoomPageCubit>().setPickDate(selectedDate);
                      }
                    }),
                    child: Container(
                      color: const Color(0xFF5CC99B),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                        child: Text(
                          DateFormat.yMMMMd().format(state.pickedDate ?? DateTime.now()),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(child: Text('Start Time')),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text('End Time')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => showTimePicker(context: context, initialTime: TimeOfDay.now()).then((selectedStartTime) {
                        if (selectedStartTime != null) {
                          context.read<SerachRoomPageCubit>().setStartTime(selectedStartTime);
                        }
                      }),
                      child: Container(
                        color: const Color(0xFF5CC99B),
                        height: 45,
                        child: Center(
                          child: BlocSelector<SerachRoomPageCubit, SearchRoomPageState, TimeOfDay?>(
                            selector: (state) => state.startTime,
                            builder: (context, startTime) => Text("${startTime?.format(context)}"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  // Text('End Time'),
                  Expanded(
                    child: InkWell(
                      onTap: () => showTimePicker(context: context, initialTime: TimeOfDay.now()).then((selectedEndTime) {
                        if (selectedEndTime != null) {
                          context.read<SerachRoomPageCubit>().setEndTime(selectedEndTime);
                        }
                      }),
                      child: Container(
                        color: const Color(0xFF5CC99B),
                        height: 45,
                        child: Center(
                          child: BlocSelector<SerachRoomPageCubit, SearchRoomPageState, TimeOfDay?>(
                            selector: (state) => state.endTime,
                            builder: (context, endTime) => Text("${endTime?.format(context)}"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: BlocBuilder<SerachRoomPageCubit, SearchRoomPageState>(
                  builder: (context, state) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5CC99B),
                    ),
                    onPressed: state.startTime != null && state.endTime != null ? () => context.read<SerachRoomPageCubit>().getAllMeetingRooms() : null,
                    child: Text('Search'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Available Room'),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocSelector<SerachRoomPageCubit, SearchRoomPageState, List<Room>?>(
                  selector: (state) => state.roomList,
                  builder: (context, roomList) => ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: roomList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MeetingRoomDetailPage(),
                            settings: RouteSettings(
                              name: 'meeting_room_detail',
                              arguments: {
                                "id": roomList?[index].id,
                              },
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all()),
                          width: MediaQuery.of(context).size.width,
                          height: 75,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              Text('Room A00${roomList?[index].id}'),
                              const Spacer(),
                              Text('${roomList?[index].capacity} Guest Max')
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
