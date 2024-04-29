import 'package:flutter_application/screens/setting/setting_notification_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//////////////////////////
// 저장된 알림 정보 로드 //
/////////////////////////

Future<void> loadButtonCheckedInfo() async {
  final switchButtonController = Get.put(SwitchButtonController());
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();
  for (int i = 0; i < switchButtonController.buttonCheckedList.length; i++) {
    switchButtonController.buttonCheckedList[i] = prefs.getBool('buttonChecked$i') ?? false; 
  }
}