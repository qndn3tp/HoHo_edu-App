import 'package:flutter/material.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/notifications/background_noti.dart';
import 'package:flutter_application/notifications/setup_noti.dart';
import 'package:flutter_application/notifications/show_noti.dart';
import 'package:flutter_application/services/login/check_perform_autologin.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'style.dart';
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
  // FCM 메시지
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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

  // 화면모드: 라이트/다크 모드
  final themeController = Get.put(ThemeController());
  await loadThemeInfo();
  if (themeController.themeMode.value == 'light') {
    Get.changeThemeMode(ThemeMode.light);
    themeController.changeIsLightTheme(true);
  } else if(themeController.themeMode.value == 'dark') {
    Get.changeThemeMode(ThemeMode.dark);  
    themeController.changeIsLightTheme(false);
  }

  runApp(
    GetMaterialApp(
      initialBinding: BindingsBuilder((){
        Get.put(DropdownButtonController());
      }),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MyApp()
    )
  );

  // 앱이 초기화되면 splash 이미지 제거
  FlutterNativeSplash.remove();                     
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());
  late Future<Widget> autoLoginFuture;    // 자동 로그인

  @override
  void initState() {
    super.initState();
    autoLoginFuture = checkAndPerformAutoLogin();
  }

  @override
  Widget build(BuildContext context) {

    // 화면모드: 시스템 모드
    if (themeController.themeMode.value == 'system') {
      changeSystemMode();
    }

    return FutureBuilder<Widget>(
      future: autoLoginFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 가져오는 중
          return SpinKitThreeBounce(color: Theme.of(context).colorScheme.onSecondary);
        } else if (snapshot.hasError) {
          // 에러 발생
          return const LoginScreen(); 
        } else {
          // 데이터에 따라 반환할 위젯을 결정
          return snapshot.data!; 
        }
      },
    );
  }
}