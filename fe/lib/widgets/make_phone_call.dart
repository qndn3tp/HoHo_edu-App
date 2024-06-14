import 'package:flutter/material.dart';
import 'package:flutter_application/style.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////////////
// 전화번호 위젯: 탭하면 전화걸기 //
///////////////////////////////////

const String phoneNumber = "1899-0898";

Widget phoneNumberText() {
  return GestureDetector(
    onTap: () async{
      try {
        await launchUrl(Uri(scheme: 'tel',path: phoneNumber));
      } catch (e) {
        null;
      }
    },
    child: Text("고객센터 연결하기($phoneNumber)", style: TextStyle(color: Theme.of(Get.context!).colorScheme.secondary, fontSize: 13),),
  );
}

Widget phoneNumberButton() {
  return GestureDetector(
    onTap: () async{
      try {
        await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
      } catch (e) {
        null;
      }
    },
    child: Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
        color: CommonColors.grey4,
         border: Border.all(color: CommonColors.grey4)),
         child: const Center(child: Text("고객센터 전화하기", style: TextStyle(color: Colors.white),)),
    ),
  );
}