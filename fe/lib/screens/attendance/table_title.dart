import 'package:flutter/material.dart';
import '../../style.dart' as style;

///////////////////////////
//    출석 테이블 제목    //
///////////////////////////

Widget tableTitle(context) {
  final Size screenSize = MediaQuery.of(context).size;

  return Container(
    margin: const EdgeInsets.only(right: 10, left: 10),
    color: style.PRIMARY_BLUE,
    height: screenSize.height * 0.05,
    child: Row(
      children: [
        // 일자
        const Expanded(
          flex: 3,
          child: Center(
            child: Text(
              "일자",
              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),
          )),
        ),
        // 수직 구분선
        Container(
          width: 1,
          color: style.GREY,
        ),
        // 내용
        const Expanded(
          flex: 7,
          child: Center(
            child: Text(
              "내용",
              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)
            )
          ),
        ),
      ],
    ));
}