import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

void getMyDeviceToken() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // 토큰
  final token = await firebaseMessaging.getToken();
  print("내 디바이스 토큰: $token");
  // sendToken(token);
}

// 클라이언트의 등록 토큰을 서버에 전송
// Future<void> sendToken(token) async {
//   String url = 'https://hohoschool.com/api/token.html'; 
//   String id = "1";
//   String clientToken = token;
//   String state = "Y";
//   final data = {
//     'id': id, 
//     'token':  clientToken, 
//     'state': state
//     };

//   try {
//     var response = await http.post(
//       Uri.parse(url), 
//       body: data
//     );
//     if (response.statusCode == 200) {
//       print('데이터가 성공적으로 전송되었습니다.');
//     } else {
//       print('데이터 전송에 실패했습니다. 상태 코드: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('오류 발생: $e');
//   }
// }