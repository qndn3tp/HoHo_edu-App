import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

// 자동로그인 컨트롤러
class AutoLoginController extends GetxController {
  var isChecked = false.obs;

  void updateCheck(bool newValue) {
    isChecked.value = newValue;
  }
}

// 자동로그인 체크박스
class AutoLogin extends StatelessWidget {
  final AutoLoginController autoLoginController = Get.put(AutoLoginController()); // 자동로그인 컨트롤러: 자동로그인 상태 관리(isChecked)

  AutoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            value: autoLoginController.isChecked.value,
            onChanged: (newValue) {
              autoLoginController.updateCheck(newValue ?? false); // isChecked의 상태 관리
            },
            activeColor: style.PRIMARY_BLUE,
          ),
        ),
        const Text("자동 로그인")
      ],
    );
  }
}