import 'package:flutter/material.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:intl/intl.dart';

////////////////////////////////
//  출석, 독서페이지 달력 Tab  //
////////////////////////////////

Widget calendarTab(String title, context) {
  // 이전-현재 날짜-다음 
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () => goToPage(title, currentPage - 1, context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).colorScheme.secondary,
        )),
      Text(
        DateFormat('yyyy.MM').format(DateTime(currentYear, currentPage + 1)),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      IconButton(
        onPressed: () => goToPage(title, currentPage + 1, context),
        icon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.secondary
        )),
    ],
  );
}

final currentMonth = getCurrentMonth();
var currentPage = currentMonth - 1;
final pageController = PageController(initialPage: currentPage);

void goToPage(String title, int newPage, context) async {
  if (newPage >= 0 && newPage < currentMonth) {
    currentPage = newPage;

    if (title == "attendance") {
      await getAttendanceData(currentPage + 1);
    } else if (title == "book") {
      await getMonthlyBookReadData(currentPage + 1);
      await getMonthlyBookScoreData(currentPage + 1);
    }
    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  } else if (newPage >= currentMonth){
    failDialog2("다음 달을 기다려주세요 :)", context);
  }
}