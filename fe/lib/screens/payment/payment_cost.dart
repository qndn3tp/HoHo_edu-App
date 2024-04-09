import 'package:flutter/material.dart';
import '../../style.dart' as style;

// 결제내용- 결제 정보(금액)
Widget paymentCost(cost) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("결제금액", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: style.DEEP_GREY)),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(text: cost, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: style.PRIMARY_DEEPBLUE)),
            const TextSpan(text: "원", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: style.DEEP_GREY))
          ]
        )
      )
    ],
  );
}