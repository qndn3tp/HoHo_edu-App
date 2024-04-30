import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_widgets.dart';
import 'package:get/get.dart';

/////////////////
//  메뉴 박스  //
/////////////////

// 안읽은 알림의 여부 컨트롤러
class UnreadNotiController extends GetxController {
  RxBool isUnread = true.obs;
}

Widget menuBox(screenSize) {
  final unreadNotiController = Get.put(UnreadNotiController());

  return Container(
    width: screenSize.width * 0.9,
    height: (screenSize.height * 0.45),
    decoration: BoxDecoration(
      color: const Color(0xfff2f2f2),
      borderRadius: BorderRadius.circular(38.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffcccccc), 
          offset: Offset(6.0, 6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Color(0xffededed),
          offset: Offset(-6.0, -6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0,
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
            // 학원비납부
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
            // 안읽은 알림 
            Obx(() => Positioned(
              left: screenSize.width / 2 - 75,
              child: unreadNotiController.isUnread.value
              ? Container(
                width: 20, 
                height: 20, 
                decoration: BoxDecoration(
                  color: Colors.red, 
                  shape: BoxShape.circle, 
                  border: Border.all(
                    color: Colors.white, 
                    width: 2, 
                  ),
                )
              ) 
              : Container()
            ))
          ],
        )
      ],
    ),
  );
}