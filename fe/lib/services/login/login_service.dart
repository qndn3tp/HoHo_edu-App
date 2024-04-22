import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/services/home/class_info.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../../utils/network_check.dart';
import '../../models/login_data.dart';
import '../../utils/login_encryption.dart';
import 'package:permission_handler/permission_handler.dart';

///////////////////////
//  로그인 로직 수행  //
///////////////////////

// 로그인 로직 수행 함수
Future<void> loginService(
    String loginId, String loginPassword, autoLoginChecked) async {
    
  // 로컬 저장소: 사용자정보(아이디,비밀번호)를 기기에 저장
  final storage = Get.find<FlutterSecureStorage>();

  // 네트워크가 연결되어있는지 체크
  var connectivityResult = await connectivityCheck();

  // 연결되어있다면 정상적으로 수행
  if (connectivityResult) {
  } else {
    // 연결되어있지 않다면 알림창 띄움
    failDialog1("연결 실패", "네트워크 연결을 확인해주세요");
  }

  // 로그인 API URL
  String url = dotenv.get('LOGIN_URL');

  // 로그인 아이디, 비밀번호
  String id = loginId;
  String shaPassword = sha256_convertHash(loginPassword); // 비밀번호: sha256으로 암호화
  String md5Password = md5_convertHash(loginPassword);

  // HTTP POST 요청
  var response = await http.post(
    Uri.parse(url),
    body: {
      'id': id, 
      'sha_pwd': shaPassword, 
      'md5_pwd': md5Password
    }
  );

  // 응답의 content-type utf-8로 인코딩으로 설정
  if (response.headers['content-type']
          ?.toLowerCase()
          .contains('charset=utf-8') !=
      true) {
    response.headers['content-type'] = 'application/json; charset=utf-8';
  }
  try {
    // 서버로부터 응답을 성공적으로 받았을 때
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      final resultList = json.decode(response.body);
      final resultValue = resultList[0]['result']; // id, pwd가 서버에 저장된 것과 같다면 "0000", "9999"

      // 로그인 성공 -> 홈 화면으로 이동
      if (resultValue == "0000") {

        UserData userData = UserData.fromJson(resultList[0]); // 서버로부터 받은 JSON 데이터를 UserData 객체리스트(userDataList)로 파싱

        // UserDataController 사용
        final UserDataController userDataController = Get.put(UserDataController());
        userDataController.setUserData(userData); // 서버로부터 받은 userData를 UserDataController에 저장

        // 자동 로그인 로직: 체크된 경우 기기 저장소에 아이디, 비밀번호 저장
        if (autoLoginChecked) {
          await storage.write(
            key: "login",
            value: "id $loginId password $loginPassword"
          );
        }

        // 수업정보 요청
        await getClassInfo();

        // 푸시알림 권한 설정
        /// 안드로이드
        await Permission.notification.request();
        PermissionStatus status = await Permission.notification.status;
        print("안드로이드 알림 권한: ${status.isGranted}");
        /// iOS
        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        print('iOS 알림 권한: ${settings.authorizationStatus}');
        
        
        // 홈화면으로 이동
        Get.offAll(const HomeScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 500)); 
      }

      // 로그인 실패 -> 알림창 띄움
      else {
        failDialog1(
          '로그인 실패',
          '아이디 또는 비밀번호를 잘못 입력했어요.'
        );
      }
    }
  }
  // 서버로부터 응답을 받지 못했을 때
  catch (e) {
    throw Exception('$e');
  }
}