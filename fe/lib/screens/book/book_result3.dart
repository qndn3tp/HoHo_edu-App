import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../style.dart' as style;
import 'book_chart.dart';

////////////////////////////
// 독서클리닉 결과3 (연간) //
////////////////////////////

class BookResult3 extends StatefulWidget {
  const BookResult3({super.key});

  @override
  State<BookResult3> createState() => _BookResult3State();
}

class _BookResult3State extends State<BookResult3> {

  // 컨트롤러 생성
  YearBookDataController yearBookDataController = Get.put(YearBookDataController());
  YMBookCountDataController ymBookCountDataController = Get.put(YMBookCountDataController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // 페이지 높이
    final pageHeight = MediaQuery.of(context).size.height - 200;

    return Column(
      children: [
        RichText(text: normalText("${DateFormat('yyyy년 M월').format(DateTime(currentYear, 1))}부터 ${DateFormat('yyyy년 M월').format(DateTime(currentYear, currentMonth))}까지")),
        // 연간 읽은 책의 권수
        RichText(
          text: TextSpan(
            children: [
              colorText("총 ${yearBookDataController.yearBookData!.total_rows}권", style.PRIMARY_GREEN),
              normalText("의 책을 읽었어요"),
            ])
        ),
        SizedBox(height: pageHeight * 0.05),
        // 독서 그래프
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30), 
          child: const BookChart()
        ),
        SizedBox(height: pageHeight * 0.05),
        // 독서 그래프 정보
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 평균 독서량
            Container(
              height: 80,
              width: screenSize.width * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xfff8f8ed),
                borderRadius: BorderRadius.circular(20),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text(
                    "평균 독서량", 
                    style: TextStyle(color: style.DEEP_GREY, fontSize: 14)), 
                  Text(
                    "${ymBookCountDataController.meanReadCount}권", 
                    style: const TextStyle(fontWeight: FontWeight.bold, color: style.PRIMARY_DEEPBLUE, fontSize: 16),)
                ],
              )
            ),
            // 다독한 달
            Container(
              height: 80,
              width: screenSize.width * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xfff8f8ed),
                borderRadius: BorderRadius.circular(15),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text(
                    "다독한 달", 
                    style: TextStyle(color: style.DEEP_GREY, fontSize: 15)), 
                  Text(
                    // "${ymBookCountDataController.maxReadCount}권 / ${ymBookCountDataController.maxReadMonth}월", 
                    "${ymBookCountDataController.maxReadMonth}월, ${ymBookCountDataController.maxReadCount}권", 
                    style: const TextStyle(fontWeight: FontWeight.bold, color: style.PRIMARY_DEEPBLUE, fontSize: 17),)
                ],
              )
            )
          ],
        ),
        SizedBox(height: pageHeight * 0.1,)
      ],
    );
  }
}