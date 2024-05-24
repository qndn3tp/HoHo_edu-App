import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:get/get.dart';

// 일반 텍스트
TextSpan normalText(text) {
  final themeController = Get.put(ThemeController());

  return TextSpan(
    text: text,
    style: TextStyle(
      color: themeController.isLightTheme.value ? Colors.black : Colors.white, 
      fontSize: 22,
      fontFamily: "BMJUA"),
  );
}
// 강조 텍스트
TextSpan colorText(text, color) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: color,
      fontSize: 22,
      fontFamily: "BMJUA")
  );
}