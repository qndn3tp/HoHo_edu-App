import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/screens/attendance/attendance_screen.dart';
import 'package:flutter_application/screens/book/book_screen.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_application/screens/notice/notice_screen.dart';
import 'package:flutter_application/screens/payment/payment_screen.dart';
import 'package:flutter_application/screens/setting/setting_screen.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/utils/logout.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:get/get.dart';

/////////////////////
// 앱 바의 사이드바 //
/////////////////////

final drawerList = [
  {
    "title": "출석체크",
    "iconPath": 'assets/images/attendance.png',
    "screen": AttendanceScreen(),
  },
  {
    "title": "학원비 납부",
    "iconPath": 'assets/images/payment.png',
    "screen": const PaymentScreen(),
  },
  {
    "title": "알림장",
    "iconPath": 'assets/images/notice.png',
    "screen": const NoticeScreen(),
  },
  {
    "title": "독클결과",
    "iconPath": 'assets/images/book.png',
    "screen": BookScreen(),
  },
  {
    "title": "설정",
    "iconPath": 'assets/images/drawer/drawer_setting.png',
    "screen": const SettingScreen(),
  },
];

Widget appbarDrawer() {
  // 학생 정보
  final classInfoDataController = Get.put(ClassInfoDataController());
  final namesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);
  final namesText = namesList.join(",");

  return Drawer(
    child: Column(
      children: [
        // 상단 프로필
        UserAccountsDrawerHeader(
          accountName: const Text("안녕하세요", style: TextStyle(color: Colors.white, fontSize: 20),),
          accountEmail: Text('$namesText학생 학부모님', style: const TextStyle(color: Colors.white, fontSize: 17),),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).colorScheme.onSecondaryContainer,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
        // 리스트
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: drawerList.length,
            itemBuilder: (c, i) {
              return GestureDetector(
                onTap: () {
                  Get.to(drawerList[i]["screen"]);
                },
                // 알림
                child: ListTile(
                  title: Text(drawerList[i]["title"].toString()),
                  leading: Container(
                    height: 25,
                    width: 25,
                    decoration: imageBoxDecoration(drawerList[i]["iconPath"].toString(), BoxFit.contain),
                  ),
                  trailing: const Icon(
                    EvaIcons.chevronRightOutline, 
                    color: CommonColors.grey4
                  ),
                ),
              );
            },
          ),
        ),
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
            leading: SizedBox(
              child: Icon(Icons.logout, color: Theme.of(Get.context!).colorScheme.secondary),
            ),
          ),
        ),
      ],
    ),
  );
}