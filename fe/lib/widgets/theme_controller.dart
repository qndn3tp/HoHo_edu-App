import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 라이트/다크 모드 컨트롤러
class ThemeController extends GetxController {
  RxBool isLightTheme = true.obs;
  
  // 로컬 저장소에 저장
  Future<void> storeThemeInfo(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLightTheme', value);
  }
}