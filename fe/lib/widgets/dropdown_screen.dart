import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/dropdown_box.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///////////////////
// 드롭다운 화면 //
///////////////////

class DropDownScreen extends GetView<DropdownButtonController> {

  // 드롭다운 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.put(DropdownButtonController());

  final String title;
  final Future<void> Function() updateData;
  final Widget monthlyScreenBuilder; 

  DropDownScreen({
    super.key, 
    required this.title, 
    required this.updateData, 
    required this.monthlyScreenBuilder
  });

  @override
  Widget build(BuildContext context) {
    dropdownButtonController.updateDropDownMenus();

    return Scaffold(
      appBar: customAppBar(title),
      body: Column(
        children: [
          dropDownBox(),
          Expanded(
            child: Obx(() {
              if (controller.currentItem.value != null) {
                return FutureBuilder<void>(
                  future: updateData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitThreeBounce(color: Theme.of(context).colorScheme.onSecondary);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // MonthlyScreen을 생성하여 반환
                      return monthlyScreenBuilder;
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ))
        ],
      ),
    );
  }
}