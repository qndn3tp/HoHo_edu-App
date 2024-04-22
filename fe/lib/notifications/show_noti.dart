import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/notifications/load_button_checked_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../screens/setting/setting_notification_screen.dart';


///////////////////////
// fcm 로컬 알림 띄우기  //
///////////////////////
Future<void> showNotification(RemoteMessage message) async {
  // 저장된 알림 정보 로드
  await loadButtonCheckedInfo();

  final switchButtonController = Get.put(SwitchButtonController());

  // 로컬 알림
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  ///////////////////
  // 데이터 메시지 //
  //////////////////
  // final noticeNum = int.parse(message.data['noticeNum']);
  // print("noticeNum: $noticeNum");
  // if (switchButtonController.buttonCheckedList[noticeNum] == true) {    // 해당 개별 알림이 true로 설정되어있는지 확인
  //     flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.data["title"],
  //     message.data["body"],

  //     // 플랫폼(android, ios)별로 로컬 알림의 세부 설정
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'high_importance_channel',              // channelId: 고유한 id 값 사용
  //         'high_importance_notification',         // channelName: 앱 설정>알림에 보여지는 이름
  //         importance: Importance.max,
  //         priority: Priority.max,
  //         color: Color(0xFF3043f2),             // 아이콘 색상
  //       ),
  //       iOS: DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentBanner: true,
  //       )
  //     ),
  //   );
  // }

  /////////////////
  // 알림 메시지 //
  /////////////////
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (switchButtonController.buttonCheckedList[0] == true) {
    print("공지알림 O");
    if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,

      // 플랫폼(android, ios)별로 로컬 알림의 세부 설정
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',              // channelId: 고유한 id 값 사용
          'high_importance_notification',         // channelName: 앱 설정>알림에 보여지는 이름
          importance: Importance.max,
          priority: Priority.max,
          color: Color(0xFF3043f2),             // 아이콘 색상
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentBanner: true,
        )
      ),
    );
  }
  } else {
    print("공지알림 X");
  }

  // if (notification != null && android != null) {
  //   flutterLocalNotificationsPlugin.show(
  //     notification.hashCode,
  //     notification.title,
  //     notification.body,

  //     // 플랫폼(android, ios)별로 로컬 알림의 세부 설정
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'high_importance_channel',              // channelId: 고유한 id 값 사용
  //         'high_importance_notification',         // channelName: 앱 설정>알림에 보여지는 이름
  //         importance: Importance.max,
  //         priority: Priority.max,
  //         color: Color(0xFF3043f2),             // 아이콘 색상
  //       ),
  //       iOS: DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentBanner: true,
  //       )
  //     ),
  //   );
  // }
}