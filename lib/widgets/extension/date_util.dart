import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CustomMessages implements Messages {
  @override
  String justNow(int seconds) => 'baru saja';
  @override
  String prefixAgo() => '';
  @override
  String suffixAgo() => '';
  @override
  String secsAgo(int seconds) => 'baru saja';
  @override
  String minAgo(int minutes) => '1m';
  @override
  String minsAgo(int minutes) => '${minutes}m';
  @override
  String hourAgo(int minutes) => '1j';
  @override
  String hoursAgo(int hours) => '${hours}j';
  @override
  String dayAgo(int hours) => '1h';
  @override
  String daysAgo(int days) => '${days}h';
  @override
  String wordSeparator() => ' ';
}

class DateUntil {
  static String formatDate(DateTime dateTime) {
    GetTimeAgo.setCustomLocaleMessages('id', CustomMessages());
    return GetTimeAgo.parse(dateTime, locale: 'id');
  }

  static String formatDateEvent(String formatDate) {
    DateTime dateParse = DateTime.parse(formatDate);
    initializeDateFormatting("id");
    return DateFormat.yMMMMEEEEd("id").format(dateParse);
  }

  static String getDate(DateTime dateTime) {
    initializeDateFormatting("id");
    return DateFormat.yMMMMEEEEd("id").format(dateTime);
  }

  static String parseDate(String formatDate) {
    DateTime dateParse = DateTime.parse(formatDate);
    final result =
        DateTime(dateParse.year, dateParse.month, dateParse.day, 9, 0, 0);
    return DateFormat("EEE dd MMMM, yyyy").format(result);
  }

  static String getFormattedDate(String formatDate) {
    DateTime dateParse = DateTime.parse(formatDate);
    final result =
        DateTime(dateParse.year, dateParse.month, dateParse.day, 9, 0, 0);
    return DateFormat("yyyy-MM-dd").format(result);
  }

  static String getFormattedDateWithHours(String formatDate) {
    DateTime dateParse = DateTime.parse(formatDate);
    final result = DateTime(dateParse.year, dateParse.month, dateParse.day,
        dateParse.hour, dateParse.minute, 9, 0, 0);
    initializeDateFormatting("id");
    return DateFormat("dd MMMM yyyy | HH:mm a", "id_ID").format(result);
  }

  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
