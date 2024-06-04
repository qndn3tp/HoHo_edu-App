import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data/report_weekly_data.dart';
import 'package:flutter_application/screens/book/hanSchool_report.dart';
import 'package:flutter_application/screens/book/school_monthly_result.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/widgets/dashed_divider.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/////////////
///북스쿨////
////////////
class BookReport extends StatefulWidget {
  final int year;
  final int month;
  final String pageDate;

  BookReport({super.key, required this.year, required this.month}) : pageDate = DateFormat('yyyy년 M월').format(DateTime(year, month));

  @override
  State<BookReport> createState() => _BookReportState();
}

class _BookReportState extends State<BookReport> {
  final dropdownButtonController = Get.put(DropdownButtonController());
  final reportWeeklyDataController = Get.put(ReportWeeklyDataController());
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe7eef8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 북스쿨 이미지
          titleImage("book_report_book.png"),
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
            text: TextSpan(children: [
              colorText(reportWeeklyDataController.iBookName, LightColors.blue),
              normalText("를 학습했어요."),
            ]),
          ),
          // 주차별 내용
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return weeklyBookResult(index + 1);
              },
            ),
          ),
          // 글쓰기 사진
          RichText(text: normalText("이번 달의 글쓰기")),
          const BookReportImage(),
          // 텍스트
          RichText(text: normalText("월간 학습 성취도 평가 결과에서")),
          RichText(
            text: TextSpan(children: [
              colorText("표현력", const Color(0xffed4282)),
              normalText("이 매우 뛰어났어요."),
            ]),
          ),
          // 최종 평가
          monthlyReportResult("book"),
        ],
      ),
    );
  }
}

// 주차별 내용
Widget weeklyBookResult(int week) {
  final reportWeeklyDataController = Get.put(ReportWeeklyDataController());
  // 해당 주차의 데이터 유무
  final isValidData = week <= reportWeeklyDataController.iWeeklyDataList.length ? true : false;

  return isValidData
  ? Stack(
    children: [
      Row(
        children: [
          // 주차
          Expanded(
            flex: 2,
            child: Center(
              child: Text( "$week주차", style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CommonColors.grey4),
            )),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 수업 내용
                  subTitleImage("book_report1.png", "수업내용", const Color(0xff34b8bc)),
                  Text(reportWeeklyDataController.iWeeklyDataList[week - 1].weekNote2),
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



// 글쓰기 이미지
class BookReportImage extends StatefulWidget {
  const BookReportImage({super.key});

  @override
  State<BookReportImage> createState() => _BookReportImageState();
}

class _BookReportImageState extends State<BookReportImage> {
  Widget imageSlider(path, index) => Image.network(path, width: 500, height: 500, fit: BoxFit.contain,);

  var images = [
    "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg",
    "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/2.jpg"
  ];
  var activeIndex = 0;

  Widget indicator() => Container(
    margin: const EdgeInsets.only(bottom: 20.0),
    alignment: Alignment.bottomCenter,
    child: AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: images.length,
      effect: JumpingDotEffect(
        dotHeight: 6,
        dotWidth: 6,
        activeDotColor: Colors.white,
        dotColor: Colors.white.withOpacity(0.6)),
    ));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(15)),
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() {
              activeIndex = index;
            }),
          ),
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final path = images[index];
            return imageSlider(path, index);
          },
        ),
        Align(alignment: Alignment.bottomCenter, child: indicator())
      ]),
    );
  }
}