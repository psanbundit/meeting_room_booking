import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room_booking/common/common_app_bar.dart';
import 'package:meeting_room_booking/controller/search_room_page_controller.dart';
import 'package:meeting_room_booking/models/room.dart';
import 'package:meeting_room_booking/detail_page/page/detail_page.dart';

class SearchRoomPage extends StatefulWidget {
  const SearchRoomPage({super.key});

  @override
  State<SearchRoomPage> createState() => _SearchRoomPageState();
}

class _SearchRoomPageState extends State<SearchRoomPage> {
  DateTime? pickedDate;
  DateTime? pickedStartTime;
  DateTime? pickedEndTime;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  List<Room> roomList = [];

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MeetRoomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date'),
            InkWell(
              onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2023, 12, 31),
                currentDate: pickedDate,
              ).then((selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    pickedDate = selectedDate;
                  });
                }
              }),
              child: Container(
                color: const Color(0xFF5CC99B),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: Center(
                  child: Text(
                    DateFormat.yMMMMd().format(pickedDate!),
                  ),
                ),
              ),
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
                        setState(() {
                          startTime = selectedStartTime;
                          pickedStartTime = DateTime(
                            pickedDate!.year,
                            pickedDate!.month,
                            pickedDate!.day,
                            selectedStartTime.hour,
                            selectedStartTime.minute,
                          );
                        });
                      }
                    }),
                    child: Container(
                      color: const Color(0xFF5CC99B),
                      height: 45,
                      child: Center(
                        child: Text("${startTime?.format(context)}"),
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
                        setState(() {
                          endTime = selectedEndTime;
                          pickedEndTime = DateTime(
                            pickedDate!.year,
                            pickedDate!.month,
                            pickedDate!.day,
                            selectedEndTime.hour,
                            selectedEndTime.minute,
                          );
                        });
                        //
                      }
                    }),
                    child: Container(
                      color: const Color(0xFF5CC99B),
                      height: 45,
                      child: Center(
                        child: Text("${endTime?.format(context)}"),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5CC99B),
                ),
                onPressed: pickedStartTime != null && pickedEndTime != null
                    ? () async => await SearchRoomPageController()
                            .getAllMeetingRooms(
                          roomList: roomList,
                          pickedStartTime: pickedStartTime!,
                          pickedEndTime: pickedEndTime!,
                        )
                            .then((_roomList) {
                          setState(() {
                            roomList = _roomList;
                          });
                        })
                    : null,
                child: Text('Search'),
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
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: roomList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MeetingRoomDetailPage(),
                        settings: RouteSettings(
                          name: 'meeting_room_detail',
                          arguments: {
                            "id": roomList[index].id,
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
                          Text('Room A00${roomList[index].id}'),
                          const Spacer(),
                          Text('${roomList[index].capacity} Guest Max')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
