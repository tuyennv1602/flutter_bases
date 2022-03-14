import 'package:flutter_base/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toFormat({String? format}) {
    final dateFormat = DateFormat(format ?? 'dd/MM/yyyy HH:mm');
    return dateFormat.format(this);
  }

  String timeAgo(BuildContext context) {
    final now = DateTime.now();
    final _diffMin = difference(now).inMinutes.abs();
    final _diffHour = difference(now).inHours.abs();
    final _diffDay = difference(now).inDays.abs();
    final _diffWeek = _diffDay ~/ 7;
    if (_diffWeek > 0) {
      return (_diffWeek > 1 ? 'time_ago.weeks_ago' : 'time_ago.week_ago')
          .translate(context)
          .replaceFirst('%s', _diffWeek.toString());
    }
    if (_diffDay > 0) {
      return (_diffDay > 1 ? 'time_ago.days_ago' : 'time_ago.day_ago')
          .translate(context)
          .replaceFirst('%s', _diffDay.toString());
    }
    if (_diffHour > 0) {
      return (_diffHour > 1 ? 'time_ago.hours_ago' : 'time_ago.hour_ago')
          .translate(context)
          .replaceFirst('%s', _diffHour.toString());
    }
    if (_diffMin > 0) {
      return (_diffMin > 1 ? 'time_ago.mins_ago' : 'time_ago.min_ago')
          .translate(context)
          .replaceFirst('%s', _diffMin.toString());
    }
    return 'time_ago.just_now'.translate(context);
  }
}
