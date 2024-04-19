import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/notifications/show_noti.dart';

///////////////////
//  백그라운드 알림  //
///////////////////
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 수신");
  showNotification(message);
}

