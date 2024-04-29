import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/////////////////////
// 이미지 박스 위젯 //
/////////////////////

BoxDecoration customBoxDecoration1(String imgPath) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(imgPath),
      fit: BoxFit.contain
    ),
  );
}

BoxDecoration customBoxDecoration2(String imgPath) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(imgPath),
      fit: BoxFit.cover
    ),
  );
}