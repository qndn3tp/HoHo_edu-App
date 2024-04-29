import 'package:flutter/material.dart';
import 'package:flutter_application/screens/book/book_result1.dart';
import 'package:flutter_application/screens/book/book_result2.dart';
import 'package:flutter_application/screens/book/book_result3.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/services/book/ym_book_read_cnt_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/calendar_tab.dart';
import 'package:flutter_application/widgets/drop_down_box.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

////////////////////////
//    독클결과 화면    //
////////////////////////

// 드롭다운 화면
class BookScreen extends GetView<DropdownButtonController> {

  // 드롭다운 버튼 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.put(DropdownButtonController());  

  BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dropdownButtonController.updateDropDownMenus();
    return Scaffold(
      appBar: customAppBar("독서클리닉 결과"),
      body: Column(
        children: [
          // 드롭다운 버튼 박스
          dropDownBox(),
          // 드롭다운 화면
          Expanded(
            child: Obx(() {
              if (controller.currentItem.value != null) {
                // 드롭다운 값이 바뀌면 api를 재호출한뒤, 렌더링
                return FutureBuilder<void>(
                  future: _updateBookData(), // api 재호출
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터를 가져오는 중
                      return Container(
                        color: style.PRIMARY_YELLOW,
                          child: const SpinKitThreeBounce(
                          color: style.LIGHT_GREY,
                        ));
                    } else if (snapshot.hasError) {
                      // 에러발생
                      return Container(
                        color: style.PRIMARY_YELLOW,
                        child: Text("Error: ${snapshot.error}"));
                    } else {
                      // 데이터를 성공적으로 가져오면 MonthlyScreen을 반환
                      currentPage = getCurrentMonth()-1;
                      return const MonthlyScreen();
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ))
        ],
      ),
    );
  }

  // 해당 드롭다운 데이터로 api 재호출
  Future<void> _updateBookData() async {
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 이전-현재 날짜-다음
          calendarTab("book"),
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
                  child: Container(
                    color: style.PRIMARY_YELLOW,
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
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}