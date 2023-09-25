import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  DateSelector(
      {super.key,
      this.height = 45,
      this.width = 120,
      this.title = 'Title',
      this.value = 'XX-XX-XXXX',
      this.onPressed});

  double width, height;
  String title, value;

  Function()? onPressed;

  void _onClickSelector(BuildContext context) {
    if (onPressed == null) return;
    onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45 + 24 + 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: const TextStyle(
                fontFamily: 'Monsterrat',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          const Spacer(),
          InkWell(
              onTap: () => _onClickSelector(context),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff5cc99b)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
