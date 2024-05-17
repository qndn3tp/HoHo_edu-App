import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data/monthly_book_score_data.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
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
  'assets/images/book/book_score_area1.png',
  'assets/images/book/book_score_area2.png',
  'assets/images/book/book_score_area3.png',
  'assets/images/book/book_score_area4.png',
  'assets/images/book/book_score_area5.png',
  'assets/images/book/book_score_area6.png',
];

Widget scoreIndicator(context, index) {
  final Size screenSize = MediaQuery.of(context).size;
  // 컨트롤러
  final BookScoreDataController bookScoreDataController = Get.put(BookScoreDataController());

  // 퍼센트 점수
  final scorePercent = bookScoreDataController.bookScoreDataList![index].per * (1 / 100);
  // 영역별 구분번호
  final areaIndex = int.parse(bookScoreDataController.bookScoreDataList![index].qType);    // 영역코드에 따른 값
  // 진행률 색상
  final progressColor = scoreColorList[areaIndex - 1];
  // 분야 이미지
  final titleImage = scoreImageList[areaIndex - 1];

  return LinearPercentIndicator(
    width: screenSize.width * 1 / 3,
    lineHeight: 20,
    percent: scorePercent,
    leading: Container(
      height: 30,
      width: 30,
      decoration: imageBoxDecoration(titleImage, BoxFit.contain)
    ),
    backgroundColor: Theme.of(context).colorScheme.onBackground,
    progressColor: progressColor,
    barRadius: const Radius.circular(10),
    animation: true,
    animationDuration: 1000,
  );
}