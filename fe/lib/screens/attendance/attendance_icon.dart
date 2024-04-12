import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/box_decoration.dart';

///////////////////////////
//    출결 상태 아이콘   //
//////////////////////////

Widget attendanceStatusIcon(attendance) {
  if (attendance == "출석") {
    return Icon(
      EvaIcons.checkmarkCircle2,
      size: 18,
      color: Colors.green[400],
    );
  } else if (attendance == "결석") {
    return Icon(
      EvaIcons.closeCircle,
      size: 18,
      color: Colors.red[400],
    );
  } else if (attendance == "지각") {
    return Icon(
      EvaIcons.alertCircle,
      size: 18,
      color: Colors.orange[400],
    );
  } else if (attendance == "보강") {
    return Icon(
      EvaIcons.plusCircle,
      size: 18,
      color: Colors.blue[400],
    );
  } else {
    return Container();
  }
}

// 출결 과목 아이콘
Widget attendanceSubjectIcon(subject) {
  // 서당(한)
  if (subject == "S") {
    return Container(
      height: 18,
      width: 18,
      decoration: customBoxDecoration('assets/images/attendance_han.png')
    );
  }
  // 독서(북) 
  else if (subject == "I") {
    return Container(
      height: 18,
      width: 18,
      decoration: customBoxDecoration('assets/images/attendance_book.png')
    );
  } else {
    return Container();
  }
}
