/////////////////////////
//  현재 시간 가져오기  //
/////////////////////////
library;

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