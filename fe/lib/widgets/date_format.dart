// 날짜 포맷팅
import 'package:intl/intl.dart';

String formatYM(int year, int month) {
  return DateFormat('yyyyMM').format(DateTime(year, month));
}

String formatYM_dot(int year, int month) {
  return DateFormat('yyyy.MM').format(DateTime(year, month));
}

String formatY(int year, int month) {
  return DateFormat('yyyy').format(DateTime(year, month));
}

String formatM(int year, int month) {
  return DateFormat('MM').format(DateTime(year, month));
}

String formatYMKorean(int year, int month) {
  return DateFormat('yyyy년 M월').format(DateTime(year, month));
}
