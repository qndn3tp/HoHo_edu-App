import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';

///////////////////////
//    홈 화면 위젯    //
///////////////////////

// 출석체크 버튼
Widget attendanceButton() {
  const title = "출석체크";

  return GestureDetector(
    onTap: () async{
      await getAttendanceData(currentMonth);
      Get.to(AttendanceScreen(), arguments: title, transition: Transition.cupertino, duration: const Duration(milliseconds: 500));
    },
    child: Container(
      alignment: Alignment.center,
      child: Column(children: [
        Container(
          height: 55,
          width: 55,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/menu_attendance.png'),
                fit: BoxFit.contain),
          ),
        ),
        const Text(
          title,
        )
      ]),
    ),
  );
}

// 학원비 납부 버튼
Widget paymentButton() {
  return GestureDetector(
    onTap: () {
      Get.to(const PaymentScreen(), transition: Transition.cupertino, duration: const Duration(milliseconds: 500));
    },
    child: Column(children: [
      Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/menu_payment.png'),
              fit: BoxFit.contain),
        ),
      ),
      const Text(
        "학원비 납부",
      )
    ]),
  );
}

// 알림장 버튼
Widget noticeButton() {
  return GestureDetector(
    onTap: () {
      Get.to(const NoticeScreen(), transition: Transition.cupertino, duration: const Duration(milliseconds: 500));
    },
    child: Column(children: [
      Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/menu_notice.png'),
              fit: BoxFit.contain),
        ),
      ),
      const Text(
        "알림장",
      )
    ]),
  );
}

// 독클결과 버튼
Widget bookButton() {
  return GestureDetector(
    // 서버로부터 독클 결과 데이터를 받은 후 독클 결과 화면으로 이동
    onTap: () async {
      await getYearlyBookData();                      // 연간 독서량 데이터
      await getMonthlyBookReadData(currentMonth-1);     // 월간 독서 데이터(책 목록, 권수)
      await getMonthlyBookScoreData(currentMonth-1);    // 월간 독서 데이터(영역별 점수)
      Get.to(BookScreen(), transition: Transition.cupertino, duration: const Duration(milliseconds: 500)); 
    },
    child: Column(children: [
      Container(
        height: 55,
        width: 55,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/menu_book.png'),
              fit: BoxFit.contain),
        ),
      ),
      const Text(
        "독클결과",
      )
    ]),
  );
}