import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const SearchRoomPage(),
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: const Color(0xFF5CC99B),
                        ),
                        onPressed: () {},
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: const ColoredBox(
                color: const Color(0xFF5CC99B),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Start Time'),
            Container(
              color: const Color(0xFF5CC99B),
              width: MediaQuery.of(context).size.width,
              height: 45,
            ),
            SizedBox(
              height: 15,
            ),
            Text('End Time'),
            Container(
              color: const Color(0xFF5CC99B),
              width: MediaQuery.of(context).size.width,
              height: 45,
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all()),
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          Text('Room A00${index + 1}'),
                          const Spacer(),
                          Text('20 Guest Max')
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
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
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
