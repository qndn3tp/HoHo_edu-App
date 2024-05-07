import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:get/get.dart';
import '../style.dart' as style;

class DropDownButtonWidget extends GetView<DropdownButtonController> {
  const DropDownButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        dropdownColor: style.LIGHT_GREY,
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        underline: Container(height: 2, color: Colors.transparent),
        // 현재 선택된 드롭다운 항목의 인덱스
        value: controller.nameList.value.indexOf(controller.currentItem.value ?? ''),
        // 드롭다운 항목을 변경(다른 것을 선택)
        onChanged: (int? index) {
          controller.changeDropDownMenu(index);
        },
        items: controller.nameList.value.map<DropdownMenuItem<int>>(
          (String menuName) {
            return DropdownMenuItem<int>(
              value: controller.nameList.value.indexOf(menuName),
              child: Text(menuName),
            );
          },
        ).toList(),
      ),
    );
  }
}