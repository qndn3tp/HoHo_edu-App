import 'package:flutter_application/screens/login/auto_login.dart';
import 'package:flutter_application/screens/login/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

// 로그아웃 함수 (아이디,비밀번호,자동로그인 초기화)
void logout() async {
  String? userInfo = "";
  final storage = Get.put(const FlutterSecureStorage());
  userInfo = await storage.read(key: "login");

  // 기기에 저장된 유저정보가 있는 경우 삭제
  if (userInfo != null) {
    await storage.delete(key: "login"); 
  }

  LoginController loginController = Get.put(LoginController());
  AutoLoginController autoLoginController = Get.put(AutoLoginController());

  // 초기화
  loginController.idController.clear(); 
  loginController.passwordController.clear();
  autoLoginController.isChecked.value = false; 
}