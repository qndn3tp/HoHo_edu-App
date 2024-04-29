import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:get/get.dart';


///////////////////////////////
// 아이디,비밀번호 입력 박스 ///
///////////////////////////////

// 아이디
InputDecoration loginIdBoxDecoration(text) {
  return InputDecoration(
    prefixIcon: const Icon(
      Icons.person_2_outlined,
      size: 20,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffeff9ff),),
      borderRadius: BorderRadius.all(Radius.circular(35))),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffd5eafc), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(35))),
    contentPadding: const EdgeInsets.all(10),
    hintText: text,
    hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
  );
}

// 비밀번호
InputDecoration loginPwdBoxDecoration(text) {

  PasswordVisibleController passwordVisibleController = Get.put(PasswordVisibleController());

  return InputDecoration(
    prefixIcon: const Icon(
      Icons.lock_outline_rounded,
      size: 20,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffeff9ff),),
      borderRadius: BorderRadius.all(Radius.circular(35))),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffd5eafc), width: 2),
      borderRadius: BorderRadius.all(Radius.circular(35))),
    contentPadding: const EdgeInsets.all(10),
    hintText: text,
    hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    suffixIcon: IconButton(
      icon: Icon(
        passwordVisibleController.passwordVisible.value
        ? Icons.visibility
        : Icons.visibility_off),
      onPressed: (){
        passwordVisibleController.switchPasswordVisibility();
      }
    )
  );
}