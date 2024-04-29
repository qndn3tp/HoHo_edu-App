import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/dropdown_button.dart';
import '../../style.dart' as style;

/////////////////////////
//  드롭다운 버튼 박스  //
/////////////////////////

Widget dropDownBox() {
  return Container(
    margin: const EdgeInsets.all(20),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: style.LIGHT_GREY,
        border: Border.all(color: style.GREY, width: 2), 
        borderRadius: BorderRadius.circular(10),
      ),
      child: const DropDownButtonWidget()),
  );
}