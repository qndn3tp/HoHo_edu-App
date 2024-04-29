import 'package:flutter/material.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:intl/intl.dart';
import '../style.dart' as style;

////////////////////////////////
//  출석, 독서페이지 달력 Tab  //
////////////////////////////////

Widget calendarTab(String pageTitle) {
  // 이전 아이콘-현재 날짜-다음 아이콘
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () => goToPreviousPage(pageTitle),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: style.DEEP_GREY,
        )),
      Text(
        DateFormat('yyyy.MM').format(DateTime(currentYear, currentPage + 1)),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      IconButton(
        onPressed: () => goToNextPage(pageTitle),
        icon: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: style.DEEP_GREY,
        )),
    ],
  );
}

final currentMonth = getCurrentMonth();
var currentPage = currentMonth - 1;
final pageController = PageController(initialPage: currentPage);

// 이전 페이지(이전 달)로 이동
void goToPreviousPage(pageTitle) async {
  if (currentPage > 0) {
    currentPage--;

    if (pageTitle == "attendance") {
      // 이전 페이지(이전 달)의 출석 데이터를 가져옴
      await getAttendanceData(currentPage + 1);
    } else if (pageTitle == "book") {
      // 이전 페이지(이전 달)의 월간 독서 데이터를 가져옴
      await getMonthlyBookReadData(currentPage + 1);
      await getMonthlyBookScoreData(currentPage + 1);
    }

    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

// 다음 페이지(다음 달)로 이동
void goToNextPage(pageTitle) async {
  if (currentPage + 1 < currentMonth) {
    currentPage++;

    if (pageTitle == "attendance") {
      // 이전 페이지(이전 달)의 출석 데이터를 가져옴
      await getAttendanceData(currentPage + 1);
    } else if (pageTitle == "book") {
      // 이전 페이지(이전 달)의 월간 독서 데이터를 가져옴
      await getMonthlyBookReadData(currentPage + 1);
      await getMonthlyBookScoreData(currentPage + 1);
    }

    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  } else {
    failDialog2("다음 달을 기다려주세요 :)");
  }
}