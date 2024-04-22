import 'package:get/get.dart';
import '../screens/setting/setting_notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 저장된 개별 알림 정보 로드(설정-알림페이지)
Future<void> loadButtonCheckedInfo() async {
  final switchButtonController = Get.put(SwitchButtonController());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();
  for (int i = 0; i < switchButtonController.buttonCheckedList.length; i++) {
    switchButtonController.buttonCheckedList[i] = prefs.getBool('buttonChecked$i') ?? false;
  }
}