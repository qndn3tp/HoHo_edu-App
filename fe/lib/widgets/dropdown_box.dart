import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/dropdown_button.dart';
import 'package:get/get.dart';

/////////////////////////
//  드롭다운 버튼 박스  //
/////////////////////////

Widget dropDownBox() {
  return Container(
    margin: const EdgeInsets.all(20),
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(Get.context!).colorScheme.onBackground, width: 2), 
        borderRadius: BorderRadius.circular(10),
      ),
      child: const DropDownButtonWidget()),
  );
}