import 'package:flutter/material.dart';
import 'package:get/get.dart';

//////////////
//  상단바  //
//////////////

PreferredSizeWidget customAppBar(title) {
  String title0 = title;

  return AppBar(
    // 뒤로가기 버튼(홈으로 이동)
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    ),
    // 제목
    title: Text(
      title0,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    // 상단바 구분선
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Divider(
        height: 1.0,
        color: Color(0xffe4e1e1),
      ),
    ),
  );
}