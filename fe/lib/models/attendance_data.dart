import 'package:get/get.dart';  

//////////////////
//  출석 데이터 //
/////////////////

// 데이터 클래스
class AttendanceData {
  final String ymd;
  final String dayname;
  final String stime;         // 등원 시간
  final String etime;         // 하원 시간
  final String gbS;
  final String timecheckS;    // 서당 출결
  final String gbI;
  final String timecheckI;    // 독서 출결
  final String check;         // ERR: 수업이 없는데 등원한 경우/OK
  
  AttendanceData({
    required this.ymd,
    required this.dayname,
    required this.stime,
    required this.etime,
    required this.gbS,
    required this.timecheckS,
    required this.gbI,
    required this.timecheckI,
    required this.check,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      ymd: json['ymd'] ?? "",
      dayname: json['dayname'] ?? "",
      stime: json['tstime'] ?? "",
      etime: json['tetime'] ?? "",
      gbS: json['gb_s'] ?? "",
      timecheckS: json['op_s_str'] ?? "",       
      gbI: json['gb_i'] ?? "",
      timecheckI: json['op_i_str'] ?? "",
      check: json['chk'] ?? "",
    );
  }
}

// 데이터 컨트롤러
class AttendanceDataController extends GetxController {
  List<AttendanceData>? _attendanceDataList;

  void setAttendanceDataList(List<AttendanceData> attendanceDataList) {
    _attendanceDataList = attendanceDataList;
    update();
  }
  List<AttendanceData>? get attendanceDataList => _attendanceDataList;
}