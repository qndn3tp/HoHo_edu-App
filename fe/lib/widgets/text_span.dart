// 일반 텍스트
import 'package:flutter/material.dart';

TextSpan normalText(text) {
  return TextSpan(
    text: text,
    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
  );
}
// 강조 텍스트
TextSpan colorText(text, color) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 22)
  );
}