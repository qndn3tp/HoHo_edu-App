import 'package:flutter/material.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/screens/home/home_menu_box.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/services/book/ym_book_read_cnt_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';
import '../../widgets/box_decoration.dart';

///////////////////////
//    홈 화면 위젯    //
///////////////////////

Widget menuButton({
  required String imagePath,
  required String buttonText,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: imageBoxDecoration1(imagePath),
        ),
        Text(buttonText, style: const TextStyle(fontSize: 15),)
      ]
    ),
  );
}

// 출석체크 버튼
Widget attendanceButton() {
  return menuButton(
    imagePath: 'assets/images/attendance.png',
    buttonText: '출석체크',
    onTap: () async {
      await getAttendanceData(currentMonth);
      Get.to(
        AttendanceScreen(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    },
  );
}

// 학원비 납부 버튼
Widget paymentButton() {
  return menuButton(
    imagePath: 'assets/images/payment.png',
    buttonText: '학원비 납부',
    onTap: () {
      Get.to(
        const PaymentScreen(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    },
  );
}

// 알림장 버튼
Widget noticeButton() {
  final readNotiController = Get.put(ReadNotiController());

  return menuButton(
    imagePath: 'assets/images/notice.png',
    buttonText: '알림장',
    onTap: () async {
      // 알림 확인
      readNotiController.isRead.value =true;
      readNotiController.storeisReadInfo(true);

      Get.to(
        const NoticeScreen(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    },
  );
}

// 독클결과 버튼
Widget bookButton() {
  return menuButton(
    imagePath: 'assets/images/book.png',
    buttonText: '독클결과',
    onTap: () async {
      await getYearlyBookData();
      await getMonthlyBookReadData(currentMonth - 1);
      await getMonthlyBookScoreData(currentMonth - 1);
      await getYMBookReadCountData();
      Get.to(
        BookScreen(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    },
  );
}