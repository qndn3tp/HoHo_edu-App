import 'package:get/get.dart';  

/////////////////////////////
//  출석 데이터, 컨트롤러   //
/////////////////////////////

// 출석 데이터 클래스
class AttendanceData {
  final String ymd;
  final String dayname;
  final String stime;
  final String etime;
  final String gbS;
  final String timecheckS;
  final String gbI;
  final String timecheckI;
  
  AttendanceData({
    required this.ymd,
    required this.dayname,
    required this.stime,
    required this.etime,
    required this.gbS,
    required this.timecheckS,
    required this.gbI,
    required this.timecheckI,
  });

  // JSON 데이터를 받아 AttendanceData 객체로 파싱
  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      ymd: json['ymd'] ?? "",
      dayname: json['dayname'] ?? "",
      stime: json['stime'] ?? "",
      etime: json['etime'] ?? "",
      gbS: json['gb_s'] ?? "",
      timecheckS: json['timechk_s'] ?? "",
      gbI: json['gb_i'] ?? "",
      timecheckI: json['timechk_i'] ?? "",
    );
  }
}

// 출석 데이터 컨트롤러
class AttendanceDataController extends GetxController {
  List<AttendanceData>? _attendanceDataList;

  void setAttendanceDataList(List<AttendanceData> attendanceDataList) {
    _attendanceDataList = attendanceDataList;
    update();
  }
    List<AttendanceData>? get attendanceDataList => _attendanceDataList;
}