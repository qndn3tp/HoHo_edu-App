import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:lottie/lottie.dart';


// 상단 알림 설명
Widget notificationInfoBox(isChecked, bellController) {
  return Container(
    height: 80,
    color: const Color(0xfffffde3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Lottie.asset(
            LottieFiles.$63788_bell_icon_notification,
            controller: bellController,
            height: 50,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isChecked
                ? notificationChecked()
                : notificationUnChecked(),
          ],
        )
      ],
    ),
  );
}

// 알림을 받는 경우
Widget notificationChecked() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("알림을 받고 있어요.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("방해금지모드나 무음모드에서는 울리지 않아요.")
    ],
  );
}

// 알림을 받지않는 경우
Widget notificationUnChecked() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("알림을 받고 있지 않아요.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("개별 알림을 받으려면 알림을 켜주세요!")    
    ],
  );
}