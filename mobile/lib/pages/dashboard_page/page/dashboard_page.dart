import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room_booking/routes.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(0),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    context.push(RouteName.searchRoomPage.path);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xFF5CC99B),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.meeting_room_rounded,
                              size: 50, color: Colors.white),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Select Meeting Room",
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  )),
              InkWell(
                  onTap: () {
                    context.push(RouteName.myBookingsPage.path);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Color(0xFF5CC99B),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.schedule, size: 50, color: Colors.white),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "My Bookings",
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  )),
            ],
          )),
    );
  }
}

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  const DashboardAppBar({super.key});

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
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      )),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: const Icon(Icons.account_circle,
                          color: Colors.white, size: 30)),
                ],
              ),
              const Text("Dashboard",
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
