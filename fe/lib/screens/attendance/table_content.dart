import 'package:flutter/material.dart';
import 'package:flutter_application/models/attendance_data.dart';
import 'package:flutter_application/screens/attendance/attendance_icon.dart';
import 'package:intl/intl.dart';
import '../../style.dart';
//////////////////////////////////
//    하단 내용(일자-출석내용)   //
//////////////////////////////////

Widget tableContent(context, AttendanceData attendanceData) {
  final Size screenSize = MediaQuery.of(context).size;
  const int columnFlex = 3; 

  // 일자
  final date = DateTime.parse(attendanceData.ymd);
  final formattedDate = DateFormat('MM.dd').format(date);
  final formattedDayname = attendanceData.dayname.substring(0, 1);
  
  // 등하원 시간
  final formattedStime = "${attendanceData.stime.substring(0, 2)}:${attendanceData.stime.substring(2)}";
  final formattedEtime = "${attendanceData.etime.substring(0, 2)}:${attendanceData.etime.substring(2)}";

  // 과목별 출석
  final subjectList = [
    [attendanceData.gbS, attendanceData.timecheckS], 
    [attendanceData.gbI, attendanceData.timecheckI],
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    height: screenSize.height * 0.1,
    color: Theme.of(context).colorScheme.onSecondary,
    child: Row(
      children: [
        // 날짜
        Expanded(
          flex: columnFlex,
          child: Center(
            child: Text('$formattedDate($formattedDayname)'),
          ),
        ),
        // 수직 구분선
        Container(width: 1, color: CommonColors.grey3),
        // 출결 세부 내용
        Expanded(
          flex: columnFlex,
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
          flex: (10 - columnFlex*2),
          child: Text(
            "(등원 $formattedStime, 하원 $formattedEtime)",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 13),
          ),
        )
      ],
    )
  );
}

// 과목별 세부 출결 내용
Widget detailTableContent(subject, status, formattedStime, formattedEtime) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // 출결 과목 아이콘
      attendanceSubjectIcon(subject),
      // 출결 상태 아이콘
      attendanceStatusIcon(status),
      // 출결 텍스트
      Text(
        "$status",
        style: const TextStyle(fontWeight: FontWeight.bold,),
      ),
    ],
  );
}