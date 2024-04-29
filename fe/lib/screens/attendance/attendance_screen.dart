import 'package:flutter/material.dart';
import 'package:flutter_application/models/attendance_data.dart';
import 'package:flutter_application/screens/attendance/table_content.dart';
import 'package:flutter_application/screens/attendance/table_title.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/calendar_tab.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/drop_down_box.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

////////////////////////
//    출석체크 화면    //
////////////////////////

// 드롭다운 화면
class AttendanceScreen extends GetView<DropdownButtonController> {
  // 드롭다운 버튼 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.put(DropdownButtonController());

  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dropdownButtonController.updateDropDownMenus();
    return Scaffold(
        appBar: customAppBar("출석 체크"),
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
                    future: _updateAttendanceData(), // api 재호출
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 데이터를 가져오는 중
                        return Container(
                          color: Colors.white,
                          child: const SpinKitThreeBounce(
                            color: style.LIGHT_GREY,
                          ));
                      } else if (snapshot.hasError) {
                        // 에러발생
                        return Container(
                          color: Colors.white,
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
            )),
          ],
        ));
  }
  // 해당 드롭다운 데이터로 api 재호출
  Future<void> _updateAttendanceData() async {
    await getAttendanceData(getCurrentMonth()); 
  }
}

// 월별 페이지 이동(PageView)
class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});

  @override
  State<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {

  @override
  Widget build(BuildContext context) {

    // 출석데이터 컨트롤러
    final attendanceDataController= Get.put(AttendanceDataController());

    return Scaffold(
      body: Column(
        children: [
          // 이전-현재 날짜-다음
          calendarTab("attendance"),
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
                return Column(
                  children: [
                    // 테이블 제목 (일자, 내용)
                    tableTitle(context),
                    // 테이블 내용(일자-출석내용)
                    Expanded(
                      child: ListView.builder(
                        itemCount: attendanceDataController.attendanceDataList!.length,
                        itemBuilder: (context, index) {
                        return tableContent(context, attendanceDataController.attendanceDataList![index]);
                        })
                    )
                  ],
                );
              }),
          )
        ],
      ),
    );
  }
}