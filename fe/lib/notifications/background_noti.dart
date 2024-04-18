import 'package:firebase_messaging/firebase_messaging.dart';

// 백그라운드 메시지 핸들러
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
    if (notification != null) {
      print("background 메시지 수신 $notification");
      String title = notification.title ?? "";
      String body = notification.body ?? "";
      print(title);
      print(body);
      // showNotification(title, body);
    } else {
      print("background 메시지 없음");
    }
  // title 조건에 맞는 것만 수신
  // print("background 메시지 수신: ${message.data}");

  // String title = message.data['title'] ?? "";
  // String body = message.data['body'] ?? "";
  // if (title == "출석") {
  //   showNotification(title, body);
  //   print("forground: 출석 알림 O");
  // } else {
  //   print("forground: 출석 알림 X");
  // }
}

