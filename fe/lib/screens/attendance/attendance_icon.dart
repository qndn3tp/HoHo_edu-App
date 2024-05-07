import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/box_decoration.dart';

///////////////////
//  출결 아이콘  //
///////////////////

const double attendanceIconSize = 18;

// 출결 상태 아이콘
Widget attendanceStatusIcon(status) {
  final Map<String, Map<String, dynamic>> statusList = {
    "출석": {"icon": EvaIcons.checkmarkCircle2, "color": Colors.green[400]},
    "결석": {"icon": EvaIcons.closeCircle, "color": Colors.red[400]},
    "지각": {"icon": EvaIcons.alertCircle, "color": Colors.orange[400]},
    "보강": {"icon": EvaIcons.plusCircle, "color": Colors.blue[400]},
  };

  if (statusList.containsKey(status)) {
    return Icon(
      statusList[status]!['icon'],
      size: attendanceIconSize,
      color: statusList[status]!['color'],
    );
  } else {
    return Container();
  }
}

// 출결 과목 아이콘
Widget attendanceSubjectIcon(subject) {
  final Map<String, String> subjectList = {
    "S": 'assets/images/attendance/attendance_han.png',   // 서당(한)
    "I": 'assets/images/attendance/attendance_book.png'   // 독서(북) 
  };

  if (subjectList.containsKey(subject)) {
    return Container(
      height: attendanceIconSize,
      width: attendanceIconSize,
      decoration: imageBoxDecoration(subjectList[subject].toString(), BoxFit.contain)
    );
  } else {
    return Container();
  }
}