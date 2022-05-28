import 'package:intl/intl.dart';

class AppDateUtils {
  static final f = DateFormat("yyyy-MM-dd HH:mm:ss");

  static String formatDate(DateTime? date,
      {String format = "yyyy-MM-dd HH:mm:ss"}) {
    date = date ?? DateTime.now();
    var f = DateFormat(format);
    return f.format(date);
  }

  static String stringToFormatedDate(String strDate,
      {String inputFormat = "dd/MM/yyyy HH:mm"}) {
    var date = DateTime.parse(strDate);
    var f = DateFormat(inputFormat);
    var formatedDate = f.format(date);
    formatedDate = formatedDate.replaceAll(" ", " às ");
    return formatedDate;
  }

  static DateTime stringToDate(String strDate) {
    var date = DateTime.parse(strDate);
    return date;
  }

  static bool isSameDate(DateTime first, DateTime other) {
    return first.year == other.year &&
        first.month == other.month &&
        first.day == other.day;
  }
}
