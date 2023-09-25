import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
