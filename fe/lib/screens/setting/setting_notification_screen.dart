import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/setting/notification_toggle.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:lottie/lottie.dart';
import '../../style.dart' as style;
import 'package:permission_handler/permission_handler.dart';


////////////////////////
//      설정 화면     //
////////////////////////

// 알림 토글 버튼 컨트롤러
class ToggleButtonController extends GetxController {
  // 토글 버튼의 이름 리스트
  final List<String> buttonNameList = [
    "알림",
    " 출석 알림",
    " 학원비 알림",
    " 알림장 알림",
    " 독클결과 알림",
  ];
  // 토글 버튼의 상태 리스트
  final List<bool> buttonCheckedList = List.filled(5, false).obs;

  // 알림 정보를 기기의 로컬저장소에 저장
  Future<void> storeButtonCheckedInfo(i) async {
    final index = i;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('buttonChecked$index', buttonCheckedList[index]);

    // 모든 버튼이 false인지 확인(알림을 받지 않는 상태), 기기의 로컬저장소에 저장
    bool allButtonsUnchecked =
        buttonCheckedList.every((element) => element == false);
    prefs.setBool('allButtonsUnchecked', allButtonsUnchecked);
  }
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with TickerProviderStateMixin {
  // 아이콘 컨트롤러
  late AnimationController bellController;

  // 알림설정 토글 버튼 컨트롤러
  final ToggleButtonController toggleButtonController = Get.put(ToggleButtonController());

  // 저장된 알림 정보 로드
  Future<void> loadButtonCheckedInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < toggleButtonController.buttonCheckedList.length; i++) {
      toggleButtonController.buttonCheckedList[i] =
          prefs.getBool('buttonChecked$i') ?? false; // 저장된 값이 있으면 불러오고, 없으면 false
    }
    // 알림 여부에 따라 화면을 업데이트
    setState(() {
      final allButtonsUnchecked = prefs.getBool('allButtonsUnchecked') ?? true;
      alarmContent(allButtonsUnchecked, bellController);
    });
  }

  @override
  void initState() {
    super.initState();
    loadButtonCheckedInfo(); // 저장된 알림 정보 로드
    bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(); // 아이콘 컨트롤러 생성
  }

  @override
  void dispose() {
    bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 모든 버튼이 false인지 확인
    bool isAllButtonsUnchecked = toggleButtonController.buttonCheckedList.every((element) => element == false);

    return Scaffold(
        backgroundColor: style.LIGHT_GREY,
        // 앱 바
        appBar: customAppBar("설정"),
        body: Column(
          children: [
            // 상단 알림 내용
            alarmContent(isAllButtonsUnchecked, bellController),
            Container(
              padding: const EdgeInsets.only(right: 10, left: 10),
              width: double.infinity,
              color: Colors.deepPurple[50], 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){}, 
                    child: const Text("알림 설정"),
                  ),
                  const ToggleButton()
                ],
              ),
            ),
            // 알림  리스트
            Expanded(
                child: ListView.builder(
              itemCount: toggleButtonController.buttonNameList.length,
              itemBuilder: (c, i) {
                return Column(
                  children: [
                    // 각 알림
                    ListTile(
                      tileColor: Colors.white,
                      title: i == 0
                      // 전체알림
                      ? Text(
                        toggleButtonController.buttonNameList[i],
                        style:
                        const TextStyle(fontWeight: FontWeight.bold),
                      )
                      // 개별알림
                      : Text(
                        toggleButtonController.buttonNameList[i],
                      ),
                      // 토글 버튼
                      trailing: Obx(() => CupertinoSwitch(
                          activeColor: style.PRIMARY_BLUE,
                          value: toggleButtonController.buttonCheckedList[i],
                          onChanged: (value) async {
                            // 전체 알림버튼: 일괄 변경
                            if (i == 0) {
                              toggleButtonController.buttonCheckedList
                                  .assignAll(List.filled(5, value));
                            } else {
                              toggleButtonController.buttonCheckedList[i] =
                                  value;
                              toggleButtonController
                                  .storeButtonCheckedInfo(i); // 알림버튼 상태를 기기에 저장
                            }
                            // 알림여부에 따라 화면 업데이트
                            setState(() {
                              isAllButtonsUnchecked = toggleButtonController
                                  .buttonCheckedList
                                  .every((element) => element == false);
                            });
                          })),
                    ),
                    // 구분선
                    const Divider(
                      height: 1,
                    ),
                  ],
                );
              },
            ))
          ],
        ));
  }
}

// 상단 알림 설명
Widget alarmContent(isAllButtonsUnchecked, bellController) {
  // 알림여부
  final bool isNotificationChecked = !(isAllButtonsUnchecked);

  return Container(
    height: 80,
    color: const Color(0xfffffde3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Lottie.asset(
            LottieFiles.$63788_bell_icon_notification,
            controller: bellController,
            height: 50,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isNotificationChecked
                ? notificationChecked()
                : notificationUnChecked(),
            const Text("방해금지모드나 무음모드에서는 울리지 않아요.")
          ],
        )
      ],
    ),
  );
}

// 알림을 받는 경우
Widget notificationChecked() {
  return const Text("알림을 받고 있어요.",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}

// 알림을 받지않는 경우
Widget notificationUnChecked() {
  return const Text("알림을 받고 있지 않아요.",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
}
