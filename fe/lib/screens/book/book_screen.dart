import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/screens/book/book_result1.dart';
import 'package:flutter_application/screens/book/book_result2.dart';
import 'package:flutter_application/screens/book/book_result3.dart';
import 'package:flutter_application/utils/dropdown_button.dart';
import 'package:flutter_application/utils/dropdown_button_controller.dart';
import 'package:flutter_application/services/book/monthly_book_read_data.dart';
import 'package:flutter_application/services/book/monthly_book_score_data.dart';
import 'package:flutter_application/services/book/yearly_book_read_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_application/widgets/drop_down_box.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../models/login_data.dart';
import 'package:intl/intl.dart';
import '../../style.dart' as style;

////////////////////////
//    독클결과 화면    //
////////////////////////

class BookScreen extends GetView<DropdownButtonController> {
  // 유저의 로그인 데이터 컨트롤러
  final UserDataController userDataController = Get.put(UserDataController());
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
            // 드롭다운 버튼 위젯
            Container(
              margin: const EdgeInsets.all(20),
              child: DecoratedBox(
                  decoration: dropDownBox(),
                  child: const DropDownButtonWidget()),
            ),
            // 드롭다운 화면
            Expanded(child: Obx(
              () {
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
        ));
  }

  // 해당 드롭다운 데이터로 api 재호출
  Future<void> _updateBookData() async {
    await getYearlyBookData();                  // 연간 독서량 데이터
    await getMonthlyBookReadData(currentMonth); // 월간 독서 데이터(책 목록, 권수)
    await getMonthlyBookScoreData(currentMonth); // 월간 독서 데이터(영역별 점수)
  }
}

// 월별 페이지 이동(PageView)
class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});

  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  // 연간독서량 데이터 컨트롤러
  final YearBookDataController yearBookDataController = Get.find();
  // 월간 독서클리닉 목록 컨트롤러
  final BookTitleDataController bookTitleDataController = Get.find();
  // 드롭다운 버튼 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.find();

  // 현재시간
  final currentMonth = getCurrentMonth();
  final currentYear = getCurrentYear();
  // 현재시간: 0000년.00월 포맷
  String formattedDate = DateFormat('yyyy.MM').format(DateTime.now());

  // 페이지 이동을 위한 페이지컨트롤러
  late PageController pageController;
  // 현재 페이지를 나타내는 변수(현재 달 - 1)
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = currentMonth - 1; // 현재 페이지(현재 달 - 1)
    pageController = PageController(
        initialPage: currentPage); // 페이지컨트롤러: 디폴트페이지는 현재 페이지(현재 달 - 1)
  }

  // 이전 페이지(이전 달)로 이동
  void goToPreviousPage() async {
    // 현재 페이지가 1월 이상이면 이전 달로 이동
    if (currentPage > 0) {
      currentPage--;

      // 이전 페이지(이전 달)의 월간 독서 데이터를 가져옴
      await getMonthlyBookReadData(currentPage + 1);
      await getMonthlyBookScoreData(currentPage + 1);

      pageController.animateToPage(
        currentPage,    
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      // }
    }
  }

  // 다음 페이지(다음 달)로 이동
  void goToNextPage() async {
    // 현재 페이지에 해당하는 달이 현재 달보다 작으면 다음 달로 이동
    if (currentPage + 1 < currentMonth) {
      currentPage++;

      // 다음 페이지(다음 달)의 월간 독서 데이터를 가져옴
      await getMonthlyBookReadData(currentPage + 1); 
      await getMonthlyBookScoreData(currentPage + 1);

      pageController.animateToPage(
      currentPage,          
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      );
    } else {
      failDialog2("다음 달을 기다려주세요 :)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 이전 아이콘-현재 날짜-다음 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: goToPreviousPage,
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: style.DEEP_GREY,
                  )),
              Text(
                DateFormat('yyyy.MM')
                    .format(DateTime(currentYear, currentPage + 1)),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              IconButton(
                  onPressed: goToNextPage,
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: style.DEEP_GREY,
                  )),
            ],
          ),
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
