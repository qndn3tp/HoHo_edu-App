import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style.dart' as style;

// 실패 알림 (설명O)
Future<dynamic> failDialog1(failTitle, failDescription) {
  return AwesomeDialog(
    context: Get.context!,
    width: 400,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    autoHide: const Duration(seconds: 3),
    title: failTitle,
    dismissOnTouchOutside: false,
    titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    desc: failDescription,
    btnOkText: "확인",
    btnOkColor: Colors.red[400],
    btnOkOnPress: () => Get.back(),
  ).show();
}

// 실패 알림 (설명X)
Future<dynamic> failDialog2(failDescription) {
  return AwesomeDialog(
    context: Get.context!,
    width: 400,
    animType: AnimType.scale,
    dialogType: DialogType.noHeader,
    autoHide: const Duration(seconds: 3),
    dismissOnTouchOutside: false,
    descTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    desc: failDescription,
    title: "",
    btnOkText: "확인",
    btnOkColor: style.PRIMARY_BLUE,
    btnOkOnPress: () => {},
  ).show();
}