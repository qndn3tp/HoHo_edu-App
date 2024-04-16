import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/notifications/show_noti.dart';
import 'package:flutter_application/notifications/token_management.dart';
import 'package:flutter_application/services/login/login_service.dart';
import 'package:flutter_application/screens/login/login_box.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../widgets/login_logo.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

///////////////////
//  로그인 화면  //
///////////////////

// 로그인 컨트롤러
class LoginController extends GetxController {
  // 사용자의 아이디, 패스워드 입력을 저장하기 위한 TextEditingController 생성
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
  LoginController loginController = Get.put(LoginController());                 // 로그인 컨트롤러
  AutoLoginController autoLoginController = Get.put(AutoLoginController());     // 자동로그인 컨트롤러
  PasswordVisibleController passwordVisibleController = Get.put(PasswordVisibleController());   // 비밀번호 숨김 컨트롤러

  // 자동로그인 저장소
  String? userInfo = ""; // 유저 정보 저장 변수
  final storage = Get.put(const FlutterSecureStorage()); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {    // 비동기로 flutter_secure_storage 정보를 불러옴
      checkStoredUserInfo();
    });
    // 로그인시 토큰 발급, 전송
    getMyDeviceToken();
    // 포그라운드 메시지
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        print("foreground 메시지 수신 $notification");
        String title = notification.title ?? "";
        String body = notification.body ?? "";
        print(title);
        print(body);
        showNotification(title, body);
      }
      else {
        print("foreground 메시지 없음");
      }
    });
  }

  // 기기에 저장된 유저 정보 체크
  checkStoredUserInfo() async {
    // read 함수를 통해 key값에 맞는 정보를 불러옴(불러오는 타입은 String 데이터가 없다면 null)
    userInfo = await storage.read(key: "login");

    if (userInfo != null) {
      String storedUserId = userInfo?.split(" ")[1] ?? ""; // 기기에 저장된 유저 아이디
      String storedUserPassword = userInfo?.split(" ")[3] ?? ""; // 기기에 저장된 유저 비밀번호

      // 저장된 유저정보가 있다면 아이디와 비밀번호가 바로 뜨도록.
      loginController.idController.text = storedUserId;
      loginController.passwordController.text = storedUserPassword;
      autoLoginController.isChecked.value = true;
    }
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
            loginLogo(),
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
                    const SizedBox(height: 20),
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

// 로그인 버튼
Widget loginButton() {
  LoginController loginController = Get.put(LoginController());              // 로그인 컨트롤러
  AutoLoginController autoLoginController = Get.put(AutoLoginController());  // 자동 로그인 컨트롤러

  return GestureDetector(
    onTap: () => loginService(
      // 아이디 입력값
      loginController.idController.text,
      // 비밀번호 입력값
      loginController.passwordController.text,
      // 자동로그인 체크값
      autoLoginController.isChecked.value,
    ),
    child: Center(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 169, 176, 255), 
                Color.fromARGB(255, 46, 57, 251), 
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1))
            ]),
        child: const Center(
          child: Icon(Icons.arrow_forward, color: Colors.white,)
        ),
      ),
    )
  );
}

// 자동로그인 컨트롤러
class AutoLoginController extends GetxController {
  var isChecked = false.obs;

  void updateCheck(bool newValue) {
    isChecked.value = newValue;
  }
}

// 자동로그인 체크박스
class AutoLogin extends StatelessWidget {
  final AutoLoginController autoLoginController = Get.put(AutoLoginController()); // 자동로그인 컨트롤러: 자동로그인 상태 관리(isChecked)

  AutoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            value: autoLoginController.isChecked.value,
            onChanged: (newValue) {
              autoLoginController.updateCheck(newValue ?? false); // isChecked의 상태 관리
            },
            activeColor: style.PRIMARY_BLUE,
          ),
        ),
        const Text("자동 로그인")
      ],
    );
  }
}

// 로그아웃 함수 (아이디,비밀번호,자동로그인 초기화)
void logout() async {
  final _LoginScreenState loginScreenState = Get.put(_LoginScreenState());
  final storage = Get.find<FlutterSecureStorage>();

  // 기기에 저장된 유저정보가 있는 경우(자동로그인)
  if (loginScreenState.userInfo != null) {
    await storage.delete(key: "login"); // 유저 정보 삭제(아이디, 비밀번호)
  }

  LoginController loginController = Get.put(LoginController());
  AutoLoginController autoLoginController = Get.put(AutoLoginController());

  loginController.idController.clear(); // 아이디 입력칸 초기화
  loginController.passwordController.clear(); // 비밀번호 입력칸 초기화
  autoLoginController.isChecked.value = false; // 자동로그인 체크 해제
}
