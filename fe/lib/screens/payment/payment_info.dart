import 'package:flutter/material.dart';

// 결제내용- 결제 정보(학생이름, 수업명, 결제일..)
Widget paymentInfo(title, body, {textColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: TextStyle(color: textColor)),
      Text(body, style: TextStyle(color: textColor)),
    ],
  );
}