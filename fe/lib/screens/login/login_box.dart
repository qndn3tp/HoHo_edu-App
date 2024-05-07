import 'package:flutter/material.dart';

///////////////////////////////
// 아이디,비밀번호 입력 박스 ///
///////////////////////////////

InputDecoration loginBoxDecoration(text, {passwordVisibleController}) {

  return InputDecoration(
    prefixIcon: Icon(
      text == "비밀번호" 
      ? Icons.lock_outline_rounded
      : Icons.person_2_outlined,
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

    suffixIcon: text == "비밀번호"
    ? IconButton(
      icon: Icon(
        passwordVisibleController.passwordVisible.value
        ? Icons.visibility
        : Icons.visibility_off),
      onPressed: passwordVisibleController.switchPasswordVisibility()
    )
    : null
  );
}