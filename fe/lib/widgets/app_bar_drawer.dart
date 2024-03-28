import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/screens/setting/setting_notification_screen.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';
import '../style.dart' as style;

// 앱 바의 사이드바
Widget appbarDrawer(context) {
  final Size screenSize = MediaQuery.of(context).size;

  ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());
  // 학생 이름
  final namesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);
  final namesText = namesList.join(", ");

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // 상단 박스 내용
        UserAccountsDrawerHeader(
          accountName: const Text("안녕하세요,", style: TextStyle(color: Colors.white, fontSize: 20),),
          accountEmail: Text('$namesText학생 학부모님', style: const TextStyle(fontSize: 17),),
          decoration: const BoxDecoration(
            color: style.PRIMARY_DEEPBLUE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        // 출석체크
        GestureDetector(
          onTap: () {
            Get.to(AttendanceScreen());
          },
          child: drawerListTile("출석체크", 'assets/images/menu_attendance.png'),
        ),
        // 학원비 납부
        GestureDetector(
          onTap: () {
            Get.to(const PaymentScreen());
          },
          child: drawerListTile("학원비 납부", 'assets/images/menu_payment.png'),
        ),
        // 알림장
        GestureDetector(
          onTap: () {
            Get.to(const NoticeScreen());
          },
          child: drawerListTile("알림장", 'assets/images/menu_notice.png'),
        ),
        // 독클 결과
        GestureDetector(
          onTap: () async{
            await getYearlyBookData();                      // 연간 독서량 데이터
            await getMonthlyBookReadData(currentMonth);     // 월간 독서 데이터(책 목록, 권수)
            await getMonthlyBookScoreData(currentMonth);    // 월간 독서 데이터(영역별 점수)
            Get.to(BookScreen());
          },
          child: drawerListTile("독클결과", 'assets/images/menu_book.png'),
        ),
        // 설정
        GestureDetector(
          onTap: () {
            Get.to(const SettingScreen());
          },
          child: drawerListTile("설정", 'assets/images/menu_setting.png'),
        ),
        // 높이 조절
        SizedBox(height: screenSize.height * 0.3),
        // 구분선
        const Divider(),
        // 로그아웃
        GestureDetector(
          onTap: () {
            // 이전의 모든 화면을 지우고 로그인 페이지로 이동
            Get.offUntil(
                GetPageRoute(
                  page: () => const LoginScreen(),
                ),
                (route) => false);
            logout();
          },
          child: drawerListTile("로그아웃", 'assets/images/menu_logout.png'),
        ),
      ],
    ),
  );
}

// 사이드바의 리스트 메뉴
Widget drawerListTile(title, imgAddress) {
  final drawerTitle = title;
  final drawerImgAddress = imgAddress;
  return ListTile(
    title: Text(drawerTitle),
    leading: Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(drawerImgAddress), fit: BoxFit.contain),
      ),
    ),
    trailing: const Icon(EvaIcons.chevronRightOutline, color: style.DEEP_GREY),
  );
}