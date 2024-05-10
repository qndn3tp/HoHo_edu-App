import 'package:flutter/material.dart';
import 'package:flutter_application/screens/book/book_result1.dart';
import 'package:flutter_application/screens/book/book_result2.dart';
import 'package:flutter_application/screens/book/book_result3.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/services/book/ym_book_read_cnt_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/calendar_tab.dart';
import 'package:flutter_application/widgets/dropdown_screen.dart';
import 'package:get/get.dart';
import '../../style.dart';
////////////////////////
//    독클결과 화면    //
////////////////////////

// 드롭다운 화면
class BookScreen extends DropDownScreen {
  BookScreen({super.key})
    : super(
      title: "독서클리닉 결과",
      updateData: _updateBookData,
      monthlyScreenBuilder: const MonthlyScreen(),
    );

  static Future<void> _updateBookData() async {
    await getYearlyBookData();
    await getMonthlyBookReadData(getCurrentMonth());
    await getMonthlyBookScoreData(getCurrentMonth());
    await getYMBookReadCountData();
  }
}

// 월별 페이지
class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});

  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  final themeController = Get.put(ThemeController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 이전-현재 날짜-다음
          calendarTab("book", context),
          // 페이지 뷰
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: getCurrentMonth(),   // 1월~현재월
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page; // 페이지를 넘기면 month가 변하도록 업데이트
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Obx(() => Container(
                    color: themeController.isLightTheme.value 
                      ? LightColors.yellow 
                      : DarkColors.basic,
                    child: Column(
                      children: [
                        // 독서클리닉 결과 1
                        BookResult1(index: index),
                        // 독서클리닉 결과 2
                        const BookResult2(),
                        // 독서클리닉 결과
                        const BookResult3()
                      ],
                    ),
                  )),
                );
              }),
          )
        ],
      ),
    );
  }
}