import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

////////////////////////
//    독클 점수 바    //
////////////////////////
final scoreColorList = [
  const Color(0xffff44b2),
  const Color(0xff5a60d8),
  const Color(0xffff7f4b),
  const Color(0xff7acf11),
  const Color(0xffffa60c),
  const Color(0xffab55e5)
];

final scoreImageList = [
  const AssetImage('assets/images/menu_book_area1.png'),
  const AssetImage('assets/images/menu_book_area2.png'),
  const AssetImage('assets/images/menu_book_area3.png'),
  const AssetImage('assets/images/menu_book_area4.png'),
  const AssetImage('assets/images/menu_book_area5.png'),
  const AssetImage('assets/images/menu_book_area6.png'),
];


Widget scoreIndicator(context, index) {
  
  final BookScoreDataController bookScoreDataController = Get.find();
  final Size screenSize = MediaQuery.of(context).size;

  // 퍼센트 점수
  final scorePercent = bookScoreDataController.bookScoreDataList![index].per * (1 / 100);
  // 영역별 구분번호
  final areaIndex = int.parse(bookScoreDataController.bookScoreDataList![index].Qtype);    // 영역코드에 따른 값
  // 진행률 색상
  final progressColor = scoreColorList[areaIndex-1];
  // 분야 이미지
  final titleImage = scoreImageList[areaIndex-1];

  return LinearPercentIndicator(
    width: screenSize.width * 1 / 3,
    lineHeight: 20,
    percent: scorePercent,
    leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: titleImage,
            fit: BoxFit.contain),
        ),
      ),
    backgroundColor: Colors.grey,
    progressColor: progressColor,
    barRadius: const Radius.circular(10),
    animation: true,
    animationDuration: 1000,
  );
}
