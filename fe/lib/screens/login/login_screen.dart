import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login/auto_login.dart';
import 'package:flutter_application/screens/login/login_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;
import '../login/login_box.dart';

///////////////////
//  로그인 화면   //
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

// 기기에 저장된 유저 정보 컨트롤러
class CheckStoredUserInfoController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  AutoLoginController autoLoginController = Get.put(AutoLoginController());

  String? userInfo = "";
  final storage = Get.put(const FlutterSecureStorage()); 

  checkStoredUserInfo() async {
    // read 함수를 통해 key값에 맞는 정보를 불러옴(불러오는 타입은 String 데이터가 없다면 null)
    userInfo = await storage.read(key: "login");

    if (userInfo != null) {
      String storedUserId = userInfo?.split(" ")[1] ?? ""; 
      String storedUserPassword = userInfo?.split(" ")[3] ?? ""; 
      
      loginController.idController.text = storedUserId;
      loginController.passwordController.text = storedUserPassword;
      autoLoginController.isChecked.value = true;
    }
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
  LoginController loginController = Get.put(LoginController());                 
  PasswordVisibleController passwordVisibleController = Get.put(PasswordVisibleController());  
  CheckStoredUserInfoController checkStoredUserInfoController = Get.put(CheckStoredUserInfoController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {    // 비동기로 flutter_secure_storage 정보를 불러옴
      checkStoredUserInfoController.checkStoredUserInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // 입력 칸 밖의 화면을 터치하면 키보드가 내려감
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 아이디
                    TextField(
                      controller: loginController.idController,
                      cursorColor: style.DEEP_GREY,
                      decoration: loginIdBoxDecoration("아이디"),
                    ),
                    const SizedBox(height: 20),
                    // 비밀번호
                    Obx(() => TextField(
                      controller: loginController.passwordController, 
                      cursorColor: style.DEEP_GREY,
                      obscureText: !passwordVisibleController.passwordVisible.value,
                      decoration: loginPwdBoxDecoration("비밀번호"),
                    )),
                    const SizedBox(height: 20),
                    // 자동로그인 버튼
                    AutoLogin(),
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