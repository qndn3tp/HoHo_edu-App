import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../style.dart';import 'book_chart.dart';

//////////////////////
// 독클 결과3 (연간) //
//////////////////////

class BookResult3 extends StatefulWidget {
  const BookResult3({super.key});

  @override
  State<BookResult3> createState() => _BookResult3State();
}

class _BookResult3State extends State<BookResult3> {
  // 컨트롤러
  YearBookDataController yearBookDataController = Get.put(YearBookDataController());          // 연간 독서량
  YMBookCountDataController ymBookCountDataController = Get.put(YMBookCountDataController()); // 연간 월별 독서량
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final pageHeight = MediaQuery.of(context).size.height - 200;
    final pointTextColor = themeController.isLightTheme.value ? LightColors.green : DarkColors.green;

    return Column(
      children: [
        // 텍스트
        RichText(
          text: normalText(
            "${DateFormat('yyyy년 M월').format(DateTime(currentYear, 1))}부터 ${DateFormat('yyyy년 M월').format(DateTime(currentYear, currentMonth))}까지"
          )),
        RichText(
          text: TextSpan(
            children: [
              colorText("총 ${yearBookDataController.yearBookData!.totalRows}권", pointTextColor),
              normalText("의 책을 읽었어요"),
            ])
        ),
        SizedBox(height: pageHeight * 0.08),
        // 독서 그래프
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30), 
          child: const BookChart()
        ),
        SizedBox(height: pageHeight * 0.08),
        // 독서 그래프 정보
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 평균 독서량
            bookChartReport(
              screenSize: screenSize,
              title: "평균 독서량", 
              value: "${ymBookCountDataController.meanReadCount}권",
            ),
            // 다독한 달
            bookChartReport(
              screenSize: screenSize,
              title: "다독한 달", 
              value: "${ymBookCountDataController.maxReadMonth}월, ${ymBookCountDataController.maxReadCount}권",
            ),
          ],
        ),
        SizedBox(height: pageHeight * 0.1)
      ],
    );
  }
}

// 독서 그래프 정보
Widget bookChartReport({required Size screenSize, required String title, required String value}) {
  final themeController = Get.put(ThemeController());

  return Container(
    height: 80,
    width: screenSize.width * 0.4,
    decoration: BoxDecoration(
      color: themeController.isLightTheme.value ? const Color(0xfff8f8ed) : CommonColors.grey5,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: themeController.isLightTheme.value ? CommonColors.grey4 : CommonColors.grey2, 
            fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: themeController.isLightTheme.value ? LightColors.indigo : DarkColors.blue, 
            fontSize: 17),
        ),
      ],
    ),
  );
}