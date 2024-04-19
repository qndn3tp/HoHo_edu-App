import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui';


///////////////////////
// fcm 로컬 알림 띄우기  //
///////////////////////
Future<void> showNotification(RemoteMessage message) async {
  // 로컬 알림
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

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
}