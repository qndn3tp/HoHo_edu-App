import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/style.dart';
import 'package:get/get.dart';

//////////////
// 학생정보 //
//////////////
Widget mypage1() {
  final screenSize = MediaQuery.of(Get.context!).size;
  const subtitleTextStyle = TextStyle(color: CommonColors.grey4);
  const bodyTextStyle = TextStyle(fontSize: 15, color: Colors.black);

  // 학생 정보
  final classInfoDataController = Get.put(ClassInfoDataController());
  final namesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);
  final namesText = namesList.join(",");
  final loginDataController = Get.put(LoginDataController());
  
  return Container(
    height: screenSize.height * 0.25,
    width: double.infinity,
    color: const Color(0xfffffde3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 학생 이름
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(namesText,
            style: const TextStyle(fontSize: 30, fontFamily: "NotoSansKR-SemiBold", color: Colors.black)),
        ),
        const Expanded(child: Text("")),
        // 센터, 자녀, 기간
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 센터 정보
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 50,
                  width: screenSize.width * 0.5 - 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("센터", style: subtitleTextStyle),
                      Text(loginDataController.loginData!.cname, style: bodyTextStyle)
                    ],
                  )),
                // 수직 구분선
                Container(color: CommonColors.grey3,width: 1,height: 50),
                // 자녀 정보
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 50,
                  width: screenSize.width * 0.5 - 11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("등록된 학생", style: subtitleTextStyle),
                      Text("${namesList.length.toString()}명", style: bodyTextStyle)
                    ],
                  )),
              ],
            ),
            // 수평 구분선
            Container(color: CommonColors.grey3, width: double.infinity, height: 1),
            // 함께한 날짜
            Container(
              margin: const EdgeInsets.only(left: 10, top: 20),
              child: const Text("호호에듀와 함께 공부한지 000일째에요 😊📖", style: bodyTextStyle,)
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    ),
  );
}
