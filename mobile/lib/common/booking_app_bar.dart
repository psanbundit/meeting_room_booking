import 'package:flutter/material.dart';

class BookingAppBar extends StatelessWidget with PreferredSizeWidget {
  BookingAppBar(
      {super.key, required this.imgSrc, required this.title, this.child});

  Widget? child = const SizedBox();
  String imgSrc = '';
  String title = '';

  @override
  Size get preferredSize => const Size.fromHeight(124);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: const Color(0xff191919),
          image: DecorationImage(
              image: AssetImage(imgSrc),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(79, 0, 0, 0), BlendMode.srcOver)),
          boxShadow: const [
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
              child != null ? child! : const Spacer(),
              Text(title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
            ],
          ),
        ));
  }
}
