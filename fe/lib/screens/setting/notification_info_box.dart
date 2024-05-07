import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:lottie/lottie.dart';

//////////////////////
//  상단 알림 설명  //
/////////////////////

Widget notificationInfoBox(isChecked, bellController) {
  return Container(
    height: 80,
    color: const Color(0xfffffde3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 알림 아이콘
        IconButton(
          onPressed: () {},
          icon: Lottie.asset(
            LottieFiles.$63788_bell_icon_notification,
            controller: bellController,
            height: 50,
          ),
        ),
        // 알림 설명
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isChecked 
              ? "알림을 받고 있어요." 
              : "알림을 받고 있지 않아요.",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              isChecked
              ? "방해금지모드나 무음모드에서는 울리지 않아요."
              : "개별 알림을 받으려면 알림을 켜주세요!",
            ),
          ],
        )
      ],
    ),
  );
}