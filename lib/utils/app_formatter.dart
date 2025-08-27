import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:intl/intl.dart';

class AppFormatter {
  static String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }
    return "$hoursStr:$minutesStr:$secondsStr";
  }

  static String formatDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  static String formatYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  static DateTime formatStringToDate(String date) {
    return DateFormat('dd-MM-yyyy').parse(date);
  }

  static DateTime formatStringYYYYMMDDToDate(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }

  /*static DateTime formatStringToDate(String date) {
    return DateFormat('dd/MMM/yyyy').parse(date);
  }*/

  static String formatDDMMMYYYY(DateTime date) {
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatDayDateString(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatBookingDateString(DateTime date) {
    return DateFormat('EEE, d MMM yyyy').format(date);
  }

  static String formatBookingDateListString(DateTime date) {
    return DateFormat("EEE, d MMM ''yy").format(date);
  }

  static String formatDateToDayString(String date) {
    return DateFormat("EEEE").format(DateFormat('yyyy-MM-dd').parse(date));
  }

  static String formatDayDateStringWithTime(DateTime date) {
    return DateFormat("EEE, d MMM ''yy hh:mm a").format(date);
  }

  static String formatToEventShortDate(String date) {
    return DateFormat("EEE, MMM d").format(DateFormat('yyyy-MM-dd').parse(date));
  }
  static String formatToDay(String date) {
    return DateFormat("d").format(DateFormat('yyyy-MM-dd').parse(date));
  }
  static String formatToMonth(String date) {
    return DateFormat("MMMM").format(DateFormat('yyyy-MM-dd').parse(date));
  }
  static String formatToEventLongDate(String date) {
    return DateFormat("d MMMM, yyyy").format(DateFormat('yyyy-MM-dd').parse(date));
  }

  static String format24to12(String time) {
    return DateFormat("hh:mm a").format(DateFormat('HH:mm:ss').parse(time));
  }

  static String formatDyMMMMd(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
 static String convertDateFormat(String inputDate) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final outputFormat = DateFormat('dd/MM/yyyy');

  DateTime dateTime = inputFormat.parse(inputDate);
  return outputFormat.format(dateTime);
}

  static String formatToHumanDate(DateTime date) {
    if(date.isSameDate(DateTime.now())){
      return 'Today';
    }
    if(date.isSameDate(DateTime.now().subtract(const Duration(days: 1)))){
      return 'Yesterday';
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String formatDoubleTimeString(double time) {
    int rounded = time.round();
    if(rounded>12){
      rounded = rounded-12;
    }
    return  "${rounded.toString().padLeft(2,"0")}:00 ${time.round()>=12 ? "PM" : "AM"}"; //;
  }

  static String formatDouble24TimeString(double time) {
    int rounded = time.round();
    return  "${rounded.toString().padLeft(2,"0")}:00"; //;
  }

  static toAge(DateTime? dateTime) {
    int age = 0;
    if (dateTime != null) {
      age = DateTime.now().difference(dateTime).inDays ~/ 365;
    }
    return '$age Yrs';
  }

  static convertSecToDay(int hour)
  {
    print("hours: $hour: ${(hour / 24)}");
    int day = (hour / 24).truncate();

    int hours = hour.remainder(24);

    return "$day days ${hours>0 ? " $hours hrs" : "" } ";
  }

  static toBase64FromPath(path){
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }
}

extension AddMonthExtension on DateTime{
  DateTime addMonths(int months) {
    final r = months % 12;
    final q = (months - r) ~/ 12;
    var newYear = this.year + q;
    var newMonth = this.month + r;
    if (newMonth > 12) {
      newYear++;
      newMonth -= 12;
    }
    final newDay = min(this.day, _daysInMonth(newYear, newMonth));
    if (this.isUtc) {
      return DateTime.utc(newYear, newMonth, newDay, this.hour, this.minute,
          this.second, this.millisecond, this.microsecond);
    } else {
      return DateTime(newYear, newMonth, newDay, this.hour, this.minute,
          this.second, this.millisecond, this.microsecond);
    }
  }

  int _daysInMonth(int year, int month) {
    var result = _daysInMonthArray[month];
    if (month == 2 && _isLeapYear(year)) result++;
    return result;
  }
  bool _isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  static const _daysInMonthArray = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
}

extension isSameDateAs on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}
