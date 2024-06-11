import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data/report_weekly_data.dart';
import 'package:flutter_application/screens/book/school_monthly_result.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/widgets/dashed_divider.dart';
import 'package:flutter_application/widgets/date_format.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/imagebox_decoration.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

///////////
//한스쿨//
//////////
class HanReport extends StatefulWidget {
  final int year;
  final int month;
  final String pageDate;

  HanReport({super.key, required this.year, required this.month}): pageDate = formatYMKorean(year, month);

  @override
  State<HanReport> createState() => _HanReportState();
}

class _HanReportState extends State<HanReport> {
  final dropdownButtonController = Get.put(DropdownButtonController());
  final reportWeeklyDataController = Get.put(ReportWeeklyDataController());
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: themeController.isLightTheme.value 
        ? const Color(0xfffaeef4) 
        : DarkColors.basic,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 한스쿨 이미지
          titleImage("book_report_han.png"),
          // 텍스트
          Obx(() => RichText(
            text: TextSpan(
              children: [
                normalText("${dropdownButtonController.currentItem.value} 학생은 "),
                normalText(widget.pageDate),
                normalText("에"),
              ]),
          )),
          RichText(
            text: TextSpan(
              children: [
                colorText(
                  reportWeeklyDataController.sBookName, 
                  themeController.isLightTheme.value ? LightColors.blue : DarkColors.blue),
                normalText("를 학습했어요."),
              ]),
          ),
          // 주차별 내용
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return weeklyHanResult(index + 1);
              },
            ),
          ),
          // 최종 평가
           monthlyReportResult("han"),
        ],
      ),
    ));
  }
}

// 주차별 내용
Widget weeklyHanResult(week) {
  final reportWeeklyDataController = Get.put(ReportWeeklyDataController());
  // 해당 주의 데이터 유무
  final isValidData = week <= reportWeeklyDataController.sWeeklyDataList.length ? true : false;

  return isValidData
    ? Stack(
      children: [
        Row(
          children: [
            // 주차
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "$week주차",
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(Get.context!).colorScheme.secondary),
                )),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 학습 어휘
                    subTitleImage("han_report1.png", "신습한자/학습어휘", const Color(0xff868ad6)),
                    Text(reportWeeklyDataController.sWeeklyDataList[week - 1].weekNote1),
                    const SizedBox(height: 5),
                    // 수업 지도
                    subTitleImage("han_report2.png", "수업지도", const Color(0xff34b8bc)),
                    Text(reportWeeklyDataController.sWeeklyDataList[week - 1].weekNote2),
                    const SizedBox(height: 5),
                    // 점수
                    subTitleImage("han_report3.png", "TEST", const Color(0xfff1a63a)),
                    LinearPercentIndicator(
                      width: 220,
                      lineHeight: 15,
                      percent: reportWeeklyDataController.sWeeklyDataList[week - 1].score / 6,
                      backgroundColor: Theme.of(Get.context!).colorScheme.onBackground,
                      progressColor: const Color(0xfff6cf35),
                      barRadius: const Radius.circular(10),
                      animation: true,
                      animationDuration: 1000,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        // 수직 구분선
        Positioned(
          top: 0,
          bottom: 0,
          left: MediaQuery.of(Get.context!).size.width / 5, // 구분선이 시작되는 위치 조정
          child: const DashedVerticalDivider(),
        ),
      ],
    )
  : const SizedBox();
}



Widget titleImage(img){
  return Container(
    height: 80,
    width: 80,
    decoration: imageBoxDecoration('assets/images/book/$img', BoxFit.contain),
  );
}

Widget subTitleImage(img, title, color) {
  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(5),
        decoration: imageBoxDecoration("assets/images/book/$img", BoxFit.contain),
      ),
      Text(
        title,
        style: TextStyle(color: color, fontFamily: "NotoSansKR-SemiBold"),
      )
    ],
  );
}
