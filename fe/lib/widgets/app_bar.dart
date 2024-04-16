import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:get/get.dart';

// 상단바
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
    title: Text(
      title0,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () => Get.offAll(const HomeScreen()),
        child: Container(
          margin: const EdgeInsets.only(right: 15,),
        height: 22,
        width: 22,
        decoration: customBoxDecoration('assets/images/appbar/appbar_home.png'),
      ),
      ),
    ],
    bottom: const PreferredSize(
      // 상단바 구분선
      preferredSize: Size.fromHeight(1.0),
      child: Divider(
        height: 1.0,
        color: Color(0xffe4e1e1),
      ),
    ),
  );
}
