import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


///////////////////
//  fcm 알림 세팅  //
///////////////////
Future<void> setupNotifications({isFlutterLocalNotificationsInitialized}) async {
  print("@@@@@@셋업@@@@@@");

  // iOS: 포그라운드 메시지 프레젠테이션 옵션 업데이트
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Android: 채널 
  const channel = AndroidNotificationChannel(     
    'high_importance_channel', 
    'high_importance_notification',
    importance: Importance.max,
  );

  // Android: 알림 채널 생성, 초기화(Android에서는 알림을 표시하기 전에 채널을 설정)
  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);

  // 플랫폼별 로컬 알림 초기 설정 
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_notification"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
      ),
    ),
  );
}