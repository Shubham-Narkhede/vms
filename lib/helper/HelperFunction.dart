import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunction {
  static String dateFormat(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

  static String dateStringFromat(String format, String dateTime) {
    return DateFormat(format).format(DateTime.parse(dateTime)).toString();
  }

  static showFlushbarSuccess(BuildContext context, String msg) {
    return Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      message: msg,
      duration: const Duration(milliseconds: 900),
    )..show(context);
  }

  static showFlushbarError(BuildContext context, String msg) {
    return Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      message: msg,
      duration: const Duration(seconds: 2),
    )..show(context);
  }
  
  /// here we have created one method which gives us time slots
  static Iterable<TimeOfDay> getTimes() sync* {
    const startTime = TimeOfDay(hour: 10, minute: 0);
    const endTime = TimeOfDay(hour: 22, minute: 0);
    const step = Duration(minutes: 30);

    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }
}
