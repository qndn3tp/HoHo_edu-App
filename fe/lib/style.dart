import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const PRIMARY_BLUE = Color(0xff3c46ff);
const PRIMARY_ORANGE = Color(0xffff5a00);
const PRIMARY_GREEN = Color(0xff0096a0);
const PRIMARY_DEEPBLUE = Color(0xff2933e1);
const PRIMARY_YELLOW = Color(0xfffffff4);
const DEEP_GREY = Color(0xff5a5a5a);
const GREY = Color(0xffc1c5c7);
const LIGHT_GREY = Color(0xfff8f8f8);
const DARK_WHITE = Color(0xfff2f2f2);

var theme = ThemeData(
  // 배경색
  scaffoldBackgroundColor: Colors.white,

  // 로그인 입력칸 
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    filled: true,
    fillColor:  Color(0xffeff9ff),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
  ),

  textTheme: const TextTheme(
  ),

  dialogTheme: const DialogTheme(
    
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    )
  );
