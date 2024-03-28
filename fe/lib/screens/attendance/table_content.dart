import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/attendance_data.dart';
import 'package:flutter_application/screens/attendance/attendance_icon.dart';
import 'package:intl/intl.dart';
import '../../style.dart' as style;

//////////////////////////////////
//    하단 내용(일자-출석내용)   //
//////////////////////////////////

Widget tableContent(context, AttendanceData attendanceData) {
  final Size screenSize = MediaQuery.of(context).size;

  // 일자
  final date = DateTime.parse(attendanceData.ymd);
  final formattedDate = DateFormat('MM.dd').format(date);
  final formattedDayname = attendanceData.dayname.substring(0, 1);
  // 등하원시간
  final formattedStime = "${attendanceData.stime.substring(0, 2)}:${attendanceData.stime.substring(2)}";
  final formattedEtime = "${attendanceData.etime.substring(0, 2)}:${attendanceData.etime.substring(2)}";

  // 과목별 출석
  final subjectList = [
    [attendanceData.gb_s, attendanceData.timechk_s], 
    [attendanceData.gb_i, attendanceData.timechk_i],
  ];

  return Container(
    margin: const EdgeInsets.only(right: 10, left: 10),
    height: screenSize.height * 0.1,
    color: style.LIGHT_GREY,
    child: Row(
      children: [
        // 날짜
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              '$formattedDate($formattedDayname)'
            ),
          ),
        ),
        // 수직 구분선
        SizedBox(
          width: 1,
          child: Container(color: style.GREY,),
        ),
        // 출결 세부 내용
        Expanded(
          flex: 3,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subjectList.length,
            itemBuilder: (context, index) {
              return detailTableContent(                      
                subjectList[index][0], 
                subjectList[index][1], 
                formattedStime,
                formattedEtime,
              );    
            }
          ),
        ),
        // 등하원 시간
        Expanded(
          flex: 4,
          child: Text(
            "(등원 $formattedStime, 하원 $formattedEtime)",
            style: const TextStyle(color: style.DEEP_GREY, fontSize: 13),
          ),
        )
      ],
    )
  );
}

// 과목별 세부 출결 내용
Widget detailTableContent(subject, attendance, formattedStime, formattedEtime) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // 출결 과목 아이콘
      attendanceSubjectIcon(subject),
      // 출결 상태 아이콘
      attendanceStatusIcon(attendance),
      // 출결 텍스트
      Text(
        "$attendance",
        style: const TextStyle(fontWeight: FontWeight.bold,),
      ),
    ],
  );
}