import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:get/get.dart';

// 일반 텍스트
TextSpan normalText(text) {
  final themeController = Get.put(ThemeController());

  return TextSpan(
    text: text,
    style: TextStyle(
      color: themeController.isLightTheme.value ? Colors.black : Colors.white, 
      fontWeight: FontWeight.bold, 
      fontSize: 20),
  );
}
// 강조 텍스트
TextSpan colorText(text, color) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 20)
  );
}