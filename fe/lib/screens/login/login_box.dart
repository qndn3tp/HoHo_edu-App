import 'package:flutter/material.dart';

InputDecoration loginBoxDecoration(text) {
  return InputDecoration(
      prefixIcon: Icon(
        text == "아이디"
        ? Icons.person_2_outlined
        : Icons.lock_outline_rounded,
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
      hintStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold));
}
