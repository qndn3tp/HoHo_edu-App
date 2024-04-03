import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {

  late bool _isChecked = false; // Initialize _isChecked to false

  @override
  void initState() {
    super.initState();
    // Check notification permission on widget initialization
    checkNotificationPermission();
  }

  Future<void> checkNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    setState(() {
      _isChecked = status.isGranted;
      print("알림권한$_isChecked");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          openAppSettings();      // 앱 알림설정으로 이동
          checkNotificationPermission();  // 알림설정에 따라 토글버튼의 상태 변경
        });
      },
    );
  }
}
