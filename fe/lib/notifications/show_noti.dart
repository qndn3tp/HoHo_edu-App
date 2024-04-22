import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/notifications/load_button_checked_info.dart';
import 'package:flutter_application/screens/setting/setting_notification_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:ui';

//////////////////////////
// fcm 로컬 알림 띄우기  //
//////////////////////////
Future<void> showNotification(RemoteMessage message) async {
  // 저장된 개별 알림 정보 로드
  await loadButtonCheckedInfo();
  final switchButtonController = Get.put(SwitchButtonController());

  // 로컬 알림 설정
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // 데이터 메시지 수신
  final noticeNum = int.parse(message.data['noticeNum']); // 개별 알림 구분번호

  // 사용자가 허용한 개별알림만 수신
  if (switchButtonController.buttonCheckedList[noticeNum] == true) {    
      flutterLocalNotificationsPlugin.show(
      0,
      message.data["title"],
      message.data["body"],

      // 플랫폼(android, ios)별 로컬 알림의 세부 설정
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',              // channelId: 고유한 id 값 사용
          'high_importance_notification',         // channelName: 앱 설정>알림에 보여지는 이름
          importance: Importance.max,
          priority: Priority.max,
          color: Color(0xFF3043f2),      
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentBanner: true,
        )
      ),
    );
  } else {
    print("알림 X");
  }
}