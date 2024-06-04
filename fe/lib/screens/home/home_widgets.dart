import 'package:flutter/material.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/screens/home/home_menu_box.dart';
import 'package:flutter_application/services/attendance/get_attendance_data.dart';
import 'package:flutter_application/services/book/get_first_book_read_date_data.dart';
import 'package:flutter_application/services/book/get_monthly_book_read_data.dart';
import 'package:flutter_application/services/book/get_monthly_book_score_data.dart';
import 'package:flutter_application/services/book/get_yearly_book_read_count_data.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/services/book/get_ym_book_read_cnt_data.dart';
import 'package:flutter_application/services/book/school_report/get_is_report_class_exist.dart';
import 'package:flutter_application/services/book/school_report/get_report_weekly_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/utils/network_check.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:get/get.dart';
import '../../widgets/imagebox_decoration.dart';

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
          margin: const EdgeInsets.only(bottom: 10),
          height: 60,
          width: 60,
          decoration: imageBoxDecoration(imagePath, BoxFit.contain),
        ),
        Text(buttonText, style: const TextStyle(fontSize: 17, fontFamily: 'NotoSansKR-SemiBold'),)
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
  final ConnectivityController connectivityController = Get.put(ConnectivityController());        // 네트워크 연결체크

  return menuButton(
    imagePath: 'assets/images/book.png',
    buttonText: '독클결과',
    onTap: () async {
      // 네트워크 연결 체크
      if (connectivityController.isConnected.value) {
        await getIsReportClassExist(currentYear, currentMonth - 1);
        await getReportWeeklyData(currentYear, currentMonth -1);
        await getFirstBookReadDateData();
        await getMonthlyBookReadData(currentYear, currentMonth - 1);
        await getMonthlyBookScoreData(currentYear, currentMonth - 1);
        await getYearlyBookReadCountData(currentYear, currentMonth - 1);
        await getYMBookReadCountData(currentYear, currentMonth - 1);
        
        Get.to(
          BookScreen(),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        failDialog1("연결 실패", "인터넷 연결을 확인해주세요");
      }
    }
  );
}