// 드롭다운 버튼 박스 스타일
import 'package:flutter/material.dart';
import '../../style.dart' as style;

BoxDecoration dropDownBox() {
  return BoxDecoration(
    color: style.LIGHT_GREY, //background color of dropdown button
    border: Border.all(
        color: style.GREY, width: 2), //border of dropdown button
    borderRadius: BorderRadius.circular(10),
  );
}