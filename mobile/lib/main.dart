import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palo IT Meeting Room Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5CC99B),
      ),
      home: const MeetingRoomLandingPage(),
    );
  }
}

class MeetingRoomLandingPage extends StatefulWidget {
  const MeetingRoomLandingPage({super.key});

  @override
  State<MeetingRoomLandingPage> createState() => _MeetingRoomLandingPageState();
}

class _MeetingRoomLandingPageState extends State<MeetingRoomLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // back layer
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/meeting_room.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Image.asset(
                  'assets/palo_logo.png',
                  fit: BoxFit.fitHeight,
                ),
              )
            ],
          ),
          // front layer
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 130,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                child: Text(
                  'Meeting\nRoom Booking',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 48,
                    ),
                    const SizedBox(
                      height: 144,
                      child: Text(
                        'Let’s make a meeting room booking easier. Meeting Room Booking will help you to ensure you will have a room for your meeting. Manage reservation, cancellation. ongogin or finised booking.',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: Colors.black,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 75,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor: const Color(0xFF5CC99B),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SearchRoomPage(),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 75,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                side: const BorderSide(
                                  color: Color(0xFF5CC99B),
                                  width: 1,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                  color: Color(0xFF5CC99B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

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

  final dio = Dio();

  final List<Room> roomList = [];

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  void dispose() {
    print('-----=------');
    super.dispose();
  }

  Future<void> getAllMeetingRooms({
    required DateTime pickedStartTime,
    required DateTime pickedEndTime,
  }) async {
    try {
      Response response = await dio.get('http://localhost:8080/rooms', queryParameters: {
        "startTime": pickedStartTime.toIso8601String(),
        "endTime": pickedEndTime.toIso8601String(),
      });

      roomList.clear();

      if (response.statusCode == 200) {
        List roomRes = response.data;
        for (var data in roomRes) {
          Room room = Room.fromJson(data);
          roomList.add(room);
        }
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
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
                    ? () async => await getAllMeetingRooms(
                          pickedStartTime: pickedStartTime!,
                          pickedEndTime: pickedEndTime!,
                        )
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
                        builder: (_) => const MeetingRoomDetail(),
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

class Room {
  final int? id;
  final String? name;
  final int? capacity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Room({
    this.id,
    this.name,
    this.capacity,
    this.createdAt,
    this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic>? data) {
    return Room(
      id: data?['id'],
      name: data?['name'],
      capacity: data?['capacity'],
      createdAt: DateTime.parse(data?['createdAt']),
      updatedAt: DateTime.parse(data?['updatedAt']),
    );
  }
}

class MeetRoomAppBar extends StatelessWidget with PreferredSizeWidget {
  const MeetRoomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xFF191919),
        image: DecorationImage(
          image: AssetImage('assets/app_bar_cover.png'),
          fit: BoxFit.fitHeight,
          colorFilter: ColorFilter.mode(Color.fromARGB(80, 0, 0, 0), BlendMode.overlay),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(75, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Logout',
                //     style: TextStyle(
                //       fontFamily: 'Open Sans',
                //       fontSize: 16,
                //       fontWeight: FontWeight.w400,
                //       height: 1.5,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Select Meeting Room',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class MeetingRoomDetail extends StatefulWidget {
  const MeetingRoomDetail({
    super.key,
  });

  @override
  State<MeetingRoomDetail> createState() => _MeetingRoomDetailState();
}

class _MeetingRoomDetailState extends State<MeetingRoomDetail> {
  final dio = Dio();
  Room? roomDetail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Map<String, dynamic>? data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      await getMeetingRoom(data?['id']).whenComplete(() {
        setState(() {});
      });
    });
  }

  Future<void> getMeetingRoom(int? id) async {
    try {
      Response response = await dio.get('http://localhost:8080/rooms/$id');

      if (response.statusCode == 200) {
        roomDetail = Room.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomDetail?.name ?? '-'),
      ),
    );
  }
}
