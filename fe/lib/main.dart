import 'package:flutter/material.dart';
import 'package:flutter_application/screens/book/dropdown_button_controller.dart';
import 'package:get/get.dart';
import 'style.dart' as style;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login/login_screen.dart';
import 'package:flutter/services.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();  // 앱의 바인딩 초기화(flutter engine과의 상호작용을 위한 준비)
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);               // 앱이 초기화될 때동안 splash 이미지 표시
  await dotenv.load(fileName: ".env");                                        // 환경변수 파일 로드
  await SystemChrome.setPreferredOrientations([                               // 화면을 세로방향으로 고정
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    GetMaterialApp(
      initialBinding: BindingsBuilder((){
        Get.put(DropdownButtonController());
      }),
      theme: style.theme,
      home: const MyApp()
      )
    );
  FlutterNativeSplash.remove();                                               // 앱이 초기화되면 splash 이미지 제거
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}