import 'package:intl/intl.dart';

String dateConverter(DateTime dateTime) {
  DateTime formattedDate =
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  DateTime todayNow = DateTime.now();
  DateTime yesterdayNow = DateTime.now().subtract(Duration(days: 1));

  DateTime todayDate = DateTime(todayNow.year, todayNow.month, todayNow.day);
  DateTime yesterdayDate =
      DateTime(yesterdayNow.year, yesterdayNow.month, yesterdayNow.day);

  if (formattedDate == todayDate) return "Today";
  if (formattedDate == yesterdayDate) return "Yesterday";
  return DateFormat("d MMM y").format(dateTime);
}
