import 'package:intl/intl.dart';


/////////////////////////
//  현재 시간 가져오기  //
/////////////////////////

final currentYear = getCurrentYear();
final currentMonth = getCurrentMonth();

int getCurrentYear() {
  final now = DateTime.now();
  return now.year;
}

int getCurrentMonth() {
  final now = DateTime.now();
  return now.month;
}

String getCurrentDateTime() {
  final now = DateTime.now();
  return DateFormat('yyyy.MM.dd HH:mm').format(now);
}