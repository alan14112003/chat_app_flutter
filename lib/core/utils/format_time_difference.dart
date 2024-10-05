import 'package:intl/intl.dart';

String formatTimeDifference(String inputTime) {
  // Parse chuỗi thời gian thành DateTime
  DateTime parsedTime = DateTime.parse(inputTime);
  DateTime now = DateTime.now();
  DateTime resultTime = parsedTime.add(const Duration(hours: 7));

  // Formatters cho các trường hợp khác nhau
  DateFormat sameDayFormatter = DateFormat('HH:mm');
  DateFormat sameYearFormatter = DateFormat('dd-MM HH:mm');
  DateFormat differentYearFormatter = DateFormat('dd-MM-yyyy HH:mm');

  if (parsedTime.year != now.year) {
    return differentYearFormatter.format(resultTime);
  }

  if (parsedTime.day == now.day && parsedTime.month == now.month) {
    // Cùng ngày
    return sameDayFormatter.format(resultTime);
  }

  // Cùng năm nhưng khác ngày
  return sameYearFormatter.format(resultTime);
}
