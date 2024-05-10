import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/notifications/request_noti.dart';
import 'package:flutter_application/screens/setting/notification_info_box.dart';
import 'package:flutter_application/utils/load_noti_list_info.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

//////////////////
//  설정 화면   //
//////////////////

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
  Future<void> storeButtonCheckedInfo(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('buttonChecked$index', buttonCheckedList[index]);
  }

  int get buttonCount => buttonNameList.length;
}


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with TickerProviderStateMixin {
  // 컨트롤러
  late AnimationController bellController;        // 알림 아이콘
  final SwitchButtonController switchButtonController = Get.put(SwitchButtonController()); // 알림 토글 버튼
  
  // 전체 알림 스위치
  late bool _isNotiChecked;

  // 알림 권한 여부를 체크
  Future<void> checkNotificationPermission() async {
    _isNotiChecked = await requestNotification();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadButtonCheckedInfo();
    _isNotiChecked = false;
    bellController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(); 
    checkNotificationPermission(); 
  }

  @override
  void dispose() {
    bellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tileColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      // 앱 바
      appBar: customAppBar("설정"),
      body: Column(
        children: [
          // 상단 알림 내용
          notificationInfoBox(_isNotiChecked, bellController),
          // 전체 알림 권한 
          ListTile(
            tileColor: tileColor,
            title: const Text("알림", style: TextStyle(fontWeight: FontWeight.bold,),),
            trailing: CupertinoSwitch(
              activeColor: Theme.of(context).colorScheme.onSecondaryContainer,
              value: _isNotiChecked,
              onChanged: (value) {
                openAppSettings(); // 앱 알림설정으로 이동
              },
            ),
          ),
          // 개별 알림(알림  리스트)
          Expanded(
            child: ListView.builder(
              itemCount: switchButtonController.buttonCount,
              itemBuilder: (c, i) {
                return Column(
                  children: [
                    // 각 개별 알림
                    ListTile(
                      tileColor: tileColor,
                      title: Text(switchButtonController.buttonNameList[i]),
                      // 스위치 버튼
                      trailing: Obx(() => CupertinoSwitch(
                        activeColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        trackColor: Theme.of(context).colorScheme.secondaryContainer,
                        value: switchButtonController.buttonCheckedList[i],
                        onChanged: _isNotiChecked     // 전체 알림 권한이 true -> 개별 알림 가능
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
                    const Divider(height: 1),
                  ],
                );
              },
            ))
        ],
      ));
  }
}