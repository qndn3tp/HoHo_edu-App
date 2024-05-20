import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:get/get.dart';
import '../../style.dart';

///////////////////////////////////////////
// 학생 정보 박스(센터명, 이름, 수강정보) //
///////////////////////////////////////////

Widget studentInfoBox(name) {
  final screenSize = MediaQuery.of(Get.context!).size;

  // 컨트롤러 
  final userDataController = Get.put(UserDataController());             // 유저의 로그인 데이터
  final classInfoDataController = Get.put(ClassInfoDataController());   //수업 정보
  
  // 이름:[수업정보]를 가지는 map
  final nameSubjectMap = classInfoDataController.getSubjectMap(classInfoDataController.classInfoDataList);
  // 수업정보 리스트(과목명, 과목호수, 시작시간, 종료시간, 요일)
  final subjectList = nameSubjectMap[name] ?? [];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(Get.context!).colorScheme.onSecondaryContainer,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 학생 정보 박스
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 센터 이름
            Text(
              userDataController.userData!.cname,
              style: const TextStyle(color: CommonColors.grey1,fontSize: 15,)),
            const SizedBox(height: 5),
            // 학생 이름
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  const TextSpan(
                    text: " 학생",
                    style: TextStyle(fontSize: 25)),
                ]),
            ),
            // 수강정보
            SizedBox(
              width: screenSize.width * 0.7,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: subjectList.length,
                itemBuilder: (context, index) {
                  final subjectName = subjectList[index][0];
                  final subjectNum = subjectList[index][1];
                  final formattedStartTime = "${subjectList[index][2].substring(0, 2)}:${subjectList[index][2].substring(2)}";
                  final formattedEndTime = "${subjectList[index][3].substring(0, 2)}:${subjectList[index][3].substring(2)}";
                  final dateName = subjectList[index][4];

                  return Text(
                    "[$subjectName$subjectNum] 수업중 ($dateName $formattedStartTime~$formattedEndTime)",
                    style: const TextStyle(color: CommonColors.grey1, fontSize: 15),);
                }
              )
            )
          ],
        ),
      ],
    ),
  );
}