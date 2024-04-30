import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/screens/setting/setting_notification_screen.dart';
import 'package:flutter_application/utils/logout.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:get/get.dart';
import '../style.dart' as style;

/////////////////////
// 앱 바의 사이드바 //
/////////////////////

Widget appbarDrawer(context) {
  final Size screenSize = MediaQuery.of(context).size;

  // 학생 정보
  ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());
  final namesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);
  final namesText = namesList.join(",");

  final drawerList = [
    ["출석체크", 'assets/images/attendance.png', AttendanceScreen()],
    ["학원비 납부", 'assets/images/payment.png', const PaymentScreen()],
    ["알림장", 'assets/images/notice.png', const NoticeScreen()],
    ["독클결과", 'assets/images/book.png', BookScreen()],
    ["설정", 'assets/images/drawer/drawer_setting.png', const SettingScreen()],
  ];

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // 상단 박스 내용
        UserAccountsDrawerHeader(
          accountName: const Text("안녕하세요", style: TextStyle(color: Colors.white, fontSize: 20),),
          accountEmail: Text('$namesText학생 학부모님', style: const TextStyle(fontSize: 17),),
          decoration: const BoxDecoration(
            color: style.PRIMARY_DEEPBLUE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        // 리스트
        Column(
          children: [
            for (int i=0; i<drawerList.length; i++)
              GestureDetector(
                onTap: () {
                  Get.to(drawerList[i][2]);
                },
                child: ListTile(
                  title: Text(drawerList[i][0].toString()),
                  leading: Container(
                    height: 25,
                    width: 25,
                    decoration: imageBoxDecoration1(drawerList[i][1].toString()),
                  ),
                  trailing: const Icon(EvaIcons.chevronRightOutline,color: style.DEEP_GREY),
                ),
              )
          ],
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
              GetPageRoute(page: () => const LoginScreen(),),(route) => false
            );
            logout();
          },
          child: ListTile(
            title: const Text("로그아웃"),
            leading: Container(
              height: 25,
              width: 25,
              decoration: imageBoxDecoration1('assets/images/drawer/drawer_logout.png'),
            ),
          ),
        ),
      ],
    ),
  );
}