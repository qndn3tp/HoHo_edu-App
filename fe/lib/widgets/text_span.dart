import 'package:flutter/material.dart';

// 일반 텍스트
TextSpan normalText(text) {
  return TextSpan(
    text: text,
    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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