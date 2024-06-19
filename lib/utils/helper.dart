import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static String? formatDate(DateTime? dateTime) {
    if (dateTime == null) return null;

    DateFormat format = DateFormat('dd/MM/yyyy');

    return format.format(dateTime);
  }

  static String? formatTime(BuildContext context, TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;

    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    return localizations.formatTimeOfDay(timeOfDay, alwaysUse24HourFormat: true);
  }

  static String? formatDuration(int duration) {
    double value = duration / 60;

    return _getTimeStringFromDouble(value);
  }

  static String _getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    String hourValue = _getHourString(flooredValue);
    String minuteString = _getMinuteString(decimalValue);

    return '$hourValue:$minuteString';
  }

  static String _getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  static String _getHourString(int flooredValue) {
    return '${flooredValue % 24}'.padLeft(2, '0');
  }
}
