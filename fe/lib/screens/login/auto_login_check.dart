import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

//////////////////////////
// 자동 로그인 체크 박스 //
//////////////////////////

// 자동로그인 체크 컨트롤러
class AutoLoginCheckController extends GetxController {
  var isChecked = false.obs;

  void updateCheck(bool newValue) {
    isChecked.value = newValue;
  }
}

// 자동로그인 체크박스
class AutoLoginCheck extends StatelessWidget {
  // 컨트롤러
  final autoLoginCheckController = Get.put(AutoLoginCheckController()); // 자동로그인 체크 

  AutoLoginCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            value: autoLoginCheckController.isChecked.value,
            onChanged: (newValue) {
              autoLoginCheckController.updateCheck(newValue ?? false); // isChecked의 상태 관리
            },
            activeColor: style.PRIMARY_BLUE,
          ),
        ),
        const Text("자동 로그인")
      ],
    );
  }
}