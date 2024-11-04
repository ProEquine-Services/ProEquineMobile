import 'package:flutter/material.dart';

extension StringTranslate on String {
  String get tra {
    return this;
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month
        && day == other.day;
  }
}
extension TOD on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(1, 1, 1, hour, minute);
  }
}

extension TimeFormater on TimeOfDay? {
  String get time {
    if (this == null) {
      return '';
    } else {
      return '${this!.hour.twoDigits}:${this!.minute.twoDigits}';
    }
  }
}

extension DateFromString on String? {
  String get toDate {
    if (this == null) {
      return '';
    }
    List<String> months = [
      'Jan'.tra,
      'Feb'.tra,
      'Mar'.tra,
      'Apr'.tra,
      'May'.tra,
      'Jun'.tra,
      'Jul'.tra,
      'Aug'.tra,
      'Sept'.tra,
      'Oct'.tra,
      'Nov'.tra,
      'Dec'.tra,
    ];
    try {
      DateTime dateTime = DateTime.parse(this!);
      return '${months[dateTime.month - 1]} ${dateTime.day}';
    } catch (e) {
      return '';
    }
  }
  String get toDate2 {
    ///The String format is like [31/12/2022]
    if (this == null) {
      return '';
    }

    List<int> date = this!.split('/').map((e) => int.parse(e)).toList();
    /// [date[0]] is day
    /// [date[1]] is month
    /// [date[2]] is year
    List<String> months = [
      'Jan'.tra,
      'Feb'.tra,
      'Mar'.tra,
      'Apr'.tra,
      'May'.tra,
      'Jun'.tra,
      'Jul'.tra,
      'Aug'.tra,
      'Sept'.tra,
      'Oct'.tra,
      'Nov'.tra,
      'Dec'.tra,
    ];
    try {

      return '${months[date[1] - 1]} ${date[0]}';
    } catch (e) {
      return '';
    }
  }

  String get toDateWithYear {
    if (this == null) {
      return '';
    }
    List<String> months = [
      'Jan'.tra,
      'Feb'.tra,
      'Mar'.tra,
      'Apr'.tra,
      'May'.tra,
      'Jun'.tra,
      'Jul'.tra,
      'Aug'.tra,
      'Sept'.tra,
      'Oct'.tra,
      'Nov'.tra,
      'Dec'.tra,
    ];
    try {
      DateTime dateTime = DateTime.parse(this!);
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return '';
    }
  }

  String get getMonth {
    if (this == null) {
      return '';
    }
    List<String> months = [
      'Jan'.tra,
      'Feb'.tra,
      'Mar'.tra,
      'Apr'.tra,
      'May'.tra,
      'Jun'.tra,
      'Jul'.tra,
      'Aug'.tra,
      'Sept'.tra,
      'Oct'.tra,
      'Nov'.tra,
      'Dec'.tra,
    ];
    try {
      DateTime dateTime = DateTime.parse(this!);
      return months[dateTime.month - 1];
    } catch (e) {
      return '';
    }
  }

  String get getDay {
    if (this == null) {
      return '';
    }

    try {
      DateTime dateTime = DateTime.parse(this!);
      return dateTime.day.twoDigits;
    } catch (e) {
      return '';
    }
  }
}

extension DateFomater on DateTime? {
  String get format {
    if (this == null) {
      return '';
    }
    return '${this!.year}/${this!.month}/${this!.day}';
  }

  String formatBy(String s) {
    if (this == null) {
      return '';
    }
    return '${this!.year}$s${this!.month}$s${this!.day}';
  }

  String get time {
    if (this == null) {
      return '';
    }
    return '${this!.hour.twoDigits}:${this!.minute.twoDigits}';
  }
}

extension Delayed on int {
  Future<void> get days async => await Future.delayed(Duration(days: this));

  Future<void> get hours async => await Future.delayed(Duration(hours: this));

  Future<void> get minutes async => await Future.delayed(Duration(minutes: this));

  Future<void> get seconds async => await Future.delayed(Duration(seconds: this));

  Future<void> get milliseconds async => await Future.delayed(Duration(milliseconds: this));

  Future<void> get microseconds async => await Future.delayed(Duration(microseconds: this));
}

extension Resposive on BuildContext {
  ///Return the size of the screen
  Size get mSize => MediaQuery.of(this).size;

  ///Return the width of the screen
  double get width => mSize.width;

  ///Return the height of the screen
  double get height => mSize.height;

  ///Return the [width] if the device is portrait
  ///And return the [height] if the device is landScape
  double get responsiveWidth => isPortrait ? width : height;

  ///Return the [height] if the device is portrait
  ///And return the [width] if the device is landScape
  double get responsiveHeight => isPortrait ? height : width;

  ///Return true if the screen is in portrait mode
  bool get isPortrait => width < height;

  ///Return true if the screen is in landScape mode
  bool get isLandscape => width > height;

  ///Return true if the screen [width] is less than 300
  bool get isXSmall => width < 300;

  ///Return true if the screen [width] is less than 400
  bool get isSmall => width < 400;

  ///Return true if the screen [width] is between 400 and 600
  bool get isMedium => width > 400 && width < 600;

  ///Return true if the screen [width] is greater than 600
  bool get isLarge => width > 600;

  ///Return true if the screen [width] is greater than 800
  bool get isXLarge => width > 800;

  ///Return true if the screen [width] is greater than 1200
  bool get isXXLarge => width > 1200;
}

extension TowDigits1 on String? {
  String get twoDigits {
    return '${toString().length == 1 ? '0' : ''}$this';
  }
}

extension TowDigits2 on num? {
  String get twoDigits {
    return '${toString().length == 1 ? '0' : ''}$this';
  }
}

extension WeekDay on int {
  String get dayName {
    switch (this) {
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      default:
        return '';
    }
  }
  String get dayNameLong {
    switch (this) {
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      default:
        return '';
    }
  }
  String get monthName{
    List<String> months = [
      'January'.tra,
      'February'.tra,
      'March'.tra,
      'April'.tra,
      'May'.tra,
      'June'.tra,
      'July'.tra,
      'August'.tra,
      'September'.tra,
      'October'.tra,
      'November'.tra,
      'December'.tra,
    ];
    return months[this - 1];
  }

}

extension IntToTime on int{
  String get toTime{
    return this < 13 ? '$this:00 AM' : '${(this - 12).toString().length < 2 ? '0${this - 12}' : this - 12}:00 PM';
  }
}