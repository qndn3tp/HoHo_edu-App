import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application/screens/home/home_menu_box.dart';
import 'package:flutter_application/screens/mypage/setting/setting_notification.dart';
import 'package:flutter_application/utils/load_noti_list_info.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:ui';

//////////////////////////
// fcm 로컬 알림 띄우기  //
//////////////////////////

Future<void> showNotification(RemoteMessage message) async {
  // 알림배지
  final readNotiController = Get.put(ReadNotiController());
  readNotiController.isRead.value = false;
  readNotiController.storeisReadInfo(false);

  // 저장된 개별 알림 정보 로드
  await loadButtonCheckedInfo();
  final switchButtonController = Get.put(SwitchButtonController());

  // 로컬 알림 설정
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final noticeNum = int.parse(message.data['noticeNum']); // 개별 알림 구분번호

  // 사용자가 허용한 개별알림만 수신
  if (noticeNum >= 0 && switchButtonController.buttonCheckedList[noticeNum] == true) {    
      flutterLocalNotificationsPlugin.show(
      0,
      message.data["title"],
      message.data["body"],

      // 플랫폼(android, ios)별 로컬 알림의 세부 설정
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',             
          'high_importance_notification',       
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
  }
}