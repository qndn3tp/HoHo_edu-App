import 'package:flutter/material.dart';
import '../../style.dart' as style;

// 결제내용- 결제 정보(학생이름, 수업명, 결제일..)
Widget paymentInfo(title, body) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(color: style.DEEP_GREY)),
      Text(body, style: const TextStyle(color: style.DEEP_GREY)),
    ],
  );
}