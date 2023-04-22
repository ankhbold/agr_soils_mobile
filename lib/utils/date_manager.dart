import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/* @param date - DateTime-рүү хөрвүүлэх боломжтой String
*  @param isAddOffset
*   1. true байвал хэрэглэгчийн одоогийн timezone-руу шилжүүлнэ
*   2. false байвал серверийн буюу UTC-0 timezone-руу шилжүүлнэ
* */

class MyDateManager {
  static String toClientDateTime(
      {@required String? date, bool isAddOffset = true, bool noTime = false, bool short = false, bool second = false}) {
    DateTime? now;
    DateFormat? formatter;

    try {
      now = DateFormat("yyyy.MM.dd").parse(date!);
      formatter = DateFormat("yyyy.MM.dd");
    } catch (_) {}
    try {
      now = DateFormat("yyyy-MM-dd").parse(date!);
      formatter = DateFormat("yyyy-MM-dd");
    } catch (_) {}
    try {
      now = DateFormat("yyyy-MM-dd HH:mm").parse(date!);
      formatter = DateFormat("yyyy-MM-dd HH:mm");
    } catch (_) {}
    try {
      now = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date!);
      formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
    } catch (_) {}
    try {
      now = DateFormat("yyyy.MM.dd HH:mm").parse(date!);
      formatter = DateFormat("yyyy.MM.dd HH:mm");
    } catch (_) {}
    try {
      now = DateFormat("yyyy.MM.dd HH:mm:ss").parse(date!);
      formatter = DateFormat("yyyy.MM.dd HH:mm:ss");
    } catch (_) {}

    if (noTime) {
      formatter = DateFormat("yyyy-MM-dd");
    }

    if (short) {
      formatter = DateFormat("yy/MM/dd/");
    }

    if (second) {
      formatter = DateFormat("yy/MM/dd/ HH:mm");
    }

    if (now != null) {
      int hour = now.timeZoneOffset.inHours;

      return isAddOffset
          ? formatter!.format(now.add(Duration(hours: hour - 8)))
          : formatter!.format(now.subtract(Duration(hours: hour - 8)));
    } else {
      return date!;
    }
  }


  static String getDayName({int? day}) {
    switch (day) {
      case 1:
        return "Даваа";
      case 2:
        return "Мягмар";
      case 3:
        return "Лхагва";
      case 4:
        return "Пүрэв";
      case 5:
        return "Баасан";
      case 6:
        return "Бямба";
      case 7:
        return "Ням";
    }
    return "";
  }

  static String getMonthName({int? month}) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "";
  }

  static String getMonthNametoString({DateTime? dateTime}) {
    return "${dateTime!.day} ${MyDateManager.getMonthName(month: dateTime.month)} ${dateTime.year}";
  }

  static String getDateString({@required DateTime? date}) {
    if (date == null) return "";
    return channelTimeAgo(date.millisecondsSinceEpoch, isNews: true);
  }

  static getTimeString({@required DateTime? date}) {
    return (date!.hour >= 10 ? date.hour.toString() : "0${date.hour.toString()}") +
        ":" +
        (date.minute >= 10 ? date.minute.toString() : "0${date.minute.toString()}");
  }

  static String channelTimeAgo(int timestamp, {bool isNews = false}) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm');
    var format2 = DateFormat('yyyy/MM/dd');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';
    time = format.format(date);
    if (isNews && diff.inDays >= 7) {
      time = format2.format(date);
      return time;
    }
    if (diff.inSeconds < 60) {
      return "Дөнгөж сая";
    } else if (diff.inMinutes >= 1 && diff.inMinutes <= 60) {
      return "${diff.inMinutes} минутын өмнө";
    } else if (diff.inHours >= 1 && diff.inHours <= 9) {
      return "${diff.inHours} цагийн өмнө";
    } else if (diff.inHours > 9 && diff.inHours <= 12 && format2.format(now) == format2.format(date)) {
      return "Өнөөдөр $time";
    } else if (diff.inHours > 9 && diff.inHours <= 12 && format2.format(now) != format2.format(date)) {
      return "Өчигдөр $time";
    } else if (diff.inHours > 12 && diff.inHours <= 48) {
      return "Өчигдөр $time";
    } else if (diff.inHours > 48 && diff.inHours < 72) {
      return "3 өдрийн өмнө $time";
    } else if (isNews) {
      return "${diff.inDays} өдрийн өмнө";
    } else {
      return format2.format(date);
    }
  }

  String chatTimeAgo(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inHours <= 12) {
      time = format.format(date);
    } else {
      var format1 = DateFormat('yy/MM/dd HH:mm');
      // var format1 = DateFormat('HH:mm a');
      time = format1.format(date);
    }

    return time;
  }

  static int diffDateToDay({DateTime? startDate, DateTime? endDate}) {
    int difference = endDate!.difference(startDate!).inDays;
    return difference;
  }

  static DateTime dateStringToDateTime(String dateTime) {
    DateTime date = DateFormat("yyyy-MM-dd").parse(dateTime);
    return date;
  }
}
