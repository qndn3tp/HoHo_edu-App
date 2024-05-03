import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login/auto_login.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_application/services/login/login_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../style.dart' as style;

Future<Widget> checkAndPerformAutoLogin() async {
  final autoLoginController = Get.put(AutoLoginController());
  final checkStoredUserInfoController = Get.put(CheckStoredUserInfoController());

    bool userInfoStored = await checkStoredUserInfoController.checkStoredUserInfo();
    bool autoLoginChecked = autoLoginController.isChecked.value;

    final id = checkStoredUserInfoController.storedUserId;
    final pwd = checkStoredUserInfoController.storedUserPassword;

    // 기기에 저장된 로그인정보가 있고, 자동 로그인 체크 된 경우
    // 자동 로그인 후 홈 화면으로 이동
    if (userInfoStored && autoLoginChecked) {
      loginService(id, pwd, autoLoginChecked);
      return Container(
        color: Colors.white,
        child: const Center(child: SpinKitThreeBounce(color: style.LIGHT_GREY,),),
      );
    } else {
      return const LoginScreen();
    }
  }