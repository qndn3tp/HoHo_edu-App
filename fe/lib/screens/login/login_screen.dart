import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login/auto_login_check.dart';
import 'package:flutter_application/screens/login/login_button.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;
import '../login/login_box.dart';

///////////////////
//  로그인 화면  //
///////////////////

// 로그인 컨트롤러
class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}

// 비밀번호 숨김 컨트롤러
class  PasswordVisibleController extends GetxController {
  var passwordVisible = false.obs;
    void switchPasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }
}

// 로그인 화면
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 컨트롤러
  final loginController = Get.put(LoginController());                 
  final passwordVisibleController = Get.put(PasswordVisibleController());  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 로그인 로고
            SizedBox(
              width: 120,
              height:120,
              child: Image.asset('assets/images/login_logo.png')
            ),
            // 로그인 입력
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // 입력 칸 밖의 화면을 터치 시, 키보드 입력 해제
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 아이디
                    const Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: Text("아이디", style: TextStyle(color: style.DEEP_GREY, fontWeight: FontWeight.bold, fontSize: 13),),
                    ),
                    TextField(
                      controller: loginController.idController,
                      cursorColor: style.DEEP_GREY,
                      decoration: loginBoxDecoration("아이디",),
                    ),
                    const SizedBox(height: 5),
                    // 비밀번호
                    const Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 5),
                      child: Text("비밀번호", style: TextStyle(color: style.DEEP_GREY, fontWeight: FontWeight.bold, fontSize: 13),),
                    ),
                    Obx(() => TextField(
                      controller: loginController.passwordController, 
                      cursorColor: style.DEEP_GREY,
                      obscureText: !passwordVisibleController.passwordVisible.value,
                      decoration: loginBoxDecoration("비밀번호", passwordVisibleController: passwordVisibleController),
                    )),
                    const SizedBox(height: 20),
                    // 자동로그인 버튼
                    AutoLoginCheck(),
                    const SizedBox(height: 40),
                    // 로그인 버튼
                    loginButton(),
                  ],
                ),
              ),
            ),
            // 로그인 분실 메세지
            const Text(
              "아이디/비밀번호 분실 시 직원에게 문의해주세요.",
              style: TextStyle(color: style.DEEP_GREY, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}