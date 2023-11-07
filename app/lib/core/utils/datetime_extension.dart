import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension PrettyTimeToDateTime on DateTime {
  String get prettyJustTime {
    final String h = hour.toString().padLeft(2, '0');
    final String m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get prettyDate {
    final String d = day.toString().padLeft(2, '0');
    final String m = month.toString().padLeft(2, '0');
    final String y = year.toString().padLeft(4, '0');
    return '$d.$m.$y';
  }

  String get prettyDayMonth {
    final String d = day.toString().padLeft(2, '0');
    final String m = DateFormat.MMM().format(this);

    return "$d $m";
  }

  String get prettyDaySmall {
    return DateFormat.E().format(this);
  }

  String get prettyDay {
    return DateFormat.EEEE().format(this);
  }

  String get prettyLongDate {
    return DateFormat.yMMMd().format(this);
  }

  String get prettyLongDateTime {
    return "$prettyLongDate ${DateFormat.Hm().format(this)}";
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension JsonDateTime on DateTime {
  static DateTime parseOrNow(String? dateTime) {
    return dateTime != null
        ? DateTime.tryParse(dateTime) ?? DateTime.now()
        : DateTime.now();
  }
}

class JsonTimeOfDay {
  static TimeOfDay fromString(String time) {
    List<String> timeParts = time.split(":");

    if (timeParts.length < 2) return const TimeOfDay(hour: 0, minute: 0);

    int hour = int.tryParse(timeParts[0]) ?? 0;
    int minute = int.tryParse(timeParts[1]) ?? 0;

    return TimeOfDay(hour: hour, minute: minute);
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get prettyString {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }

  static List<TimeOfDay> getMinuteIntervals(int minuteInterval) {
    int i = 0;
    List<TimeOfDay> result = [];

    while (i < 60 * 24) {
      int minute = i % 60;
      int hour = i ~/ 60;
      result.add(TimeOfDay(hour: hour, minute: minute));
      i += minuteInterval;
    }
    result.add(const TimeOfDay(hour: 23, minute: 59));

    return result;
  }

  bool operator >(TimeOfDay other) {
    if (hour > other.hour || (hour == other.hour && minute > other.minute)) {
      return true;
    }
    return false;
  }
}

extension DurationExtension on Duration {
  static Duration fromString(String durationString) {
    List<String> splitDurationString = durationString.split(":");

    List<String> secondsAndMilliSeconds =
        splitDurationString.length > 2 ? splitDurationString[2].split(".") : [];

    int checkLengthAndParseInt(List<String> stringList, targetPosition) {
      if (stringList.length > targetPosition) {
        return int.tryParse(stringList[targetPosition]) ?? 0;
      }
      return 0;
    }

    return Duration(
      hours: checkLengthAndParseInt(splitDurationString, 0),
      minutes: checkLengthAndParseInt(splitDurationString, 1),
      seconds: checkLengthAndParseInt(secondsAndMilliSeconds, 0),
      milliseconds: checkLengthAndParseInt(secondsAndMilliSeconds, 1),
    );
  }
}
