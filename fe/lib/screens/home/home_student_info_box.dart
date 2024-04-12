import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

///////////////////////////////////////////
// 학생 정보 박스(센터명, 이름, 수강정보) //
///////////////////////////////////////////

Widget studentInfoBox(context, name) {
  final screenSize = MediaQuery.of(context).size;

  // 유저 로그인 데이터 컨트롤러
  UserDataController userDataController = Get.put(UserDataController());

  // 수업 정보 데이터 컨트롤러
  ClassInfoDataController classInfoDataController =
      Get.put(ClassInfoDataController());
  // 이름:[수업정보]를 가지는 map
  Map<String, List<List<String>>> nameSubjectMap = classInfoDataController
      .getSubjectMap(classInfoDataController.classInfoDataList);
  // 수업정보 리스트(과목명, 과목호수, 시작시간, 종료시간, 요일)
  List<List<String>> subjectList = nameSubjectMap[name] ?? [];

  return Container(
    padding: const EdgeInsets.only(left: 10, right: 5),
    // 박스 스타일
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: style.PRIMARY_BLUE,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 학생 정보 박스
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 센터이름
            Text(userDataController.userData!.cname,
                style: const TextStyle(
                  color: style.DARK_WHITE,
                  fontSize: 15,
                )),
            const SizedBox(
              height: 5,
            ),
            // 학생이름
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25)),
                const TextSpan(
                    text: " 학생",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
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
                      final formattedStartTime =
                          "${subjectList[index][2].substring(0, 2)}:${subjectList[index][2].substring(2)}";
                      final formattedEndTime =
                          "${subjectList[index][3].substring(0, 2)}:${subjectList[index][3].substring(2)}";
                      final dateName = subjectList[index][4];

                      return Text(
                        "[$subjectName$subjectNum] 수업중 ($dateName $formattedStartTime~$formattedEndTime) ",
                        style: const TextStyle(
                            color: style.DARK_WHITE, fontSize: 14),
                      );
                    }))
          ],
        ),
        // 아이콘
        Container(
          height: 70,
          width: screenSize.width * 0.15,
          decoration: customBoxDecoration('assets/images/main_profile_status_on.png')
        )
      ],
    ),
  );
}
