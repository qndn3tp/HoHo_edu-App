import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_widgets.dart';

/////////////////
//  메뉴 박스  //
/////////////////

Widget menuBox(screenSize) {
  return Container(
    width: screenSize.width * 0.9,
    height: (screenSize.height * 0.45),
    decoration: BoxDecoration(
      color: const Color(0xfff2f2f2),
      borderRadius: BorderRadius.circular(38.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffcccccc), 
          offset: Offset(6.0, 6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Color(0xffededed),
          offset: Offset(-6.0, -6.0),
          blurRadius: 16.0,
          spreadRadius: 1.0,
        ),
      ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 출석체크
            attendanceButton(),
            // 학원비납부
            paymentButton(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 알림장
            noticeButton(),
            // 독클결과
            bookButton(),
          ],
        )
      ],
    ),
  );
}