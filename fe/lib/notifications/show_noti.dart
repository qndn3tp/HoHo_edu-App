import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui';


Future<void> showNotification(String title, String body) async {

  // iOS: 포그라운드 메시지 프레젠테이션 옵션 업데이트
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Android: 알림 채널 생성, 초기화(Android에서는 알림을 표시하기 전에 채널을 설정)
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(     
          'high_importance_channel', 
          'high_importance_notification',
          importance: Importance.max,
      ));

  // Android: 초기 설정, 알림 아이콘 설정
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_notification"),
    ),
  );

  flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,

    // 플랫폼(android, ios)별로 로컬 푸시의 세부 설정
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',                // channelId: 고유한 id 값 사용
        'high_importance_notification',           // channelName: 앱 설정>알림에 보여지는 이름
        importance: Importance.max,
        priority: Priority.max,
        color: Color(0xFF3043f2),             // 아이콘 색상
      ),
    ),
  );
}