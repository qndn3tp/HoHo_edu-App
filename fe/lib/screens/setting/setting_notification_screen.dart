import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/setting/notification_info_box.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style.dart' as style;

////////////////////////
//      설정 화면     //
////////////////////////


// 알림 토글 버튼 컨트롤러
class SwitchButtonController extends GetxController {
  // 토글 버튼의 이름 리스트
  final List<String> buttonNameList = [
    "공지 알림",
    "수업 알림",
    "출석 알림",
    "결제 알림",
    "독클 알림",
  ];
  // 토글 버튼의 상태 리스트
  final List<bool> buttonCheckedList = List.filled(5, false).obs;

  // 알림 정보를 기기의 로컬저장소에 저장
  Future<void> storeButtonCheckedInfo(i) async {
    final index = i;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('buttonChecked$index', buttonCheckedList[index]);
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
  final SwitchButtonController switchButtonController = Get.put(SwitchButtonController());

  // 저장된 알림 정보 로드
  Future<void> loadButtonCheckedInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < switchButtonController.buttonCheckedList.length; i++) {
      switchButtonController.buttonCheckedList[i] =
          prefs.getBool('buttonChecked$i') ?? false; // 저장된 값이 있으면 불러오고, 없으면 false
    }
  }

  // 전체 알림 스위치
  late bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    loadButtonCheckedInfo(); // 저장된 알림 정보 로드
    bellController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(); // 아이콘 컨트롤러 생성
    checkNotificationPermission(); // 알림 권한 여부를 체크(on/off)
  }

  // 알림 권한 여부를 체크
  Future<void> checkNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    setState(() {
      _isChecked = status.isGranted;
      print("알림권한$_isChecked");
    });
  }

  @override
  void dispose() {
    bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.LIGHT_GREY,
      // 앱 바
      appBar: customAppBar("설정"),
      body: Column(
        children: [
          // 상단 알림 내용
          notificationInfoBox(_isChecked, bellController),
          // 전체 알림 권한 
          ListTile(
            tileColor: Colors.white,
            title: const Text("알림",style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: CupertinoSwitch(
              activeColor: style.PRIMARY_BLUE,
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  openAppSettings(); // 앱 알림설정으로 이동
                  checkNotificationPermission(); // 알림설정에 따라 토글버튼의 상태 변경
                });
              },
            ),
          ),
          // 개별 알림(알림  리스트)
          Expanded(
            child: ListView.builder(
            itemCount: switchButtonController.buttonNameList.length,
            itemBuilder: (c, i) {
              return Column(
                children: [
                  // 각 개별 알림
                  ListTile(
                    tileColor: Colors.white,
                    title: Text( switchButtonController.buttonNameList[i],),
                    // 스위치 버튼
                    trailing: Obx(() => CupertinoSwitch(
                      activeColor: style.PRIMARY_BLUE,
                      value: switchButtonController.buttonCheckedList[i],
                      onChanged: _isChecked     // 전체 알림 권한이 true -> 개별 알림 가능
                        ? (value) {
                          setState(() {
                            switchButtonController.buttonCheckedList[i] = value;
                            switchButtonController.storeButtonCheckedInfo(i);  // 알림버튼 상태를 기기에 저장
                          });
                        }
                        : null      // 전체 알림 권한이 false -> 개별 알림 불가능
                    )),
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