import 'package:flutter/material.dart';

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
          colorFilter: ColorFilter.mode(
            Color.fromARGB(80, 0, 0, 0),
            BlendMode.overlay,
          ),
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
              ],
            ),
            Row(
              children: const [
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
