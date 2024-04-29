import 'package:flutter/material.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/notifications/background_noti.dart';
import 'package:flutter_application/notifications/setup_noti.dart';
import 'package:flutter_application/notifications/show_noti.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:get/get.dart';
import 'style.dart' as style;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> main() async{
  // 앱의 바인딩 초기화(flutter engine과의 상호작용을 위한 준비)
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();  
  // 앱이 초기화될 때동안 splash 이미지 표시
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);               

  // FCM 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  
  await setupNotification();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // 포그라운드 메시지
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("포그라운드 수신 ${message.data}");
    showNotification(message);
  });

  // 환경변수 파일 로드
  await dotenv.load(fileName: ".env");
  // 화면 세로방향 고정                                        
  await SystemChrome.setPreferredOrientations([                               
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
  FlutterNativeSplash.remove();                     // 앱이 초기화되면 splash 이미지 제거
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}