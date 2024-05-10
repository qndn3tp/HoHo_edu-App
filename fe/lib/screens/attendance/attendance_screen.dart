import 'package:flutter/material.dart';
import 'package:flutter_application/models/attendance_data.dart';
import 'package:flutter_application/screens/attendance/table_content.dart';
import 'package:flutter_application/screens/attendance/table_title.dart';
import 'package:flutter_application/services/attendance/time_check.dart';
import 'package:flutter_application/widgets/calendar_tab.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/dropdown_screen.dart';
import 'package:get/get.dart';

////////////////////////
//    출석체크 화면    //
////////////////////////

// 드롭다운 화면
class AttendanceScreen extends DropDownScreen {
  AttendanceScreen({super.key})
    : super(
      title: "출석 체크",
      updateData: _updateAttendanceData,
      monthlyScreenBuilder: const MonthlyScreen(),
    );

  static Future<void> _updateAttendanceData() async {
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
    final attendanceDataController = Get.put(AttendanceDataController());

    return Scaffold(
      body: Column(
        children: [
          // 이전-현재 날짜-다음
          calendarTab("attendance", context),
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