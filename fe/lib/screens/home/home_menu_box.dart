import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_widgets.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/////////////////
//  메뉴 박스  //
/////////////////

// 푸시 알림 확인 여부 컨트롤러
class ReadNotiController extends GetxController {
  RxBool isRead = true.obs;

  // 로컬 저장소에 저장
  Future<void> storeisReadInfo(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRead', value);
  }
}

Widget menuBox(Size screenSize) {
  final readNotiController = Get.put(ReadNotiController());
  final themeController = Get.put(ThemeController());

  return Obx(() => Container(
    width: screenSize.width * 0.9,
    height: screenSize.height * 0.45,
    decoration: BoxDecoration(
      color: themeController.isLightTheme.value 
        ? const Color(0xfff2f2f2) 
        : const Color(0xff3c3c3c),
      borderRadius: BorderRadius.circular(38.5),
      boxShadow: [
        BoxShadow(
          color: themeController.isLightTheme.value 
            ? const Color(0xffcccccc) 
            : const Color(0xff2e2e2e), 
          offset: const Offset(6.0, 6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0
        ),
        BoxShadow(
          color: themeController.isLightTheme.value 
            ? const Color(0xffededed) 
            : const Color(0xff292929), 
          offset: const Offset(-6.0, -6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0
        ),
      ]),
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 출석체크
            attendanceButton(),
            // 학원비내역
            paymentButton(),
          ],
        ),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 알림장
                noticeButton(),
                // 독클결과
                bookButton(),
              ],
            ),
            // 알림 확인 여부에 따른 배지
            Obx(() => Positioned(
              left: screenSize.width / 2 - 75,
              child: readNotiController.isRead.value
              ? Container()           // 알림 확인 O  
              : Container(            // 알림 확인 X
                width: 22, 
                height: 22, 
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value ? const Color(0xffff3939): const Color.fromARGB(255, 250, 84, 84),
                  shape: BoxShape.circle, 
                  border: Border.all(
                    color: themeController.isLightTheme.value ? const Color(0xfff2f2f2): const Color(0xff3c3c3c), 
                    width: 4, 
                  ),
                )
              )
            )
            ) 
          ],
        ),
      ],
    ),
  ));
}