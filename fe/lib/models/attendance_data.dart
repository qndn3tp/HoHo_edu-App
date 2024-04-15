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
  final String gb_s;
  final String timechk_s;
  final String gb_i;
  final String timechk_i;

  
  AttendanceData({
    required this.ymd,
    required this.dayname,
    required this.stime,
    required this.etime,
    required this.gb_s,
    required this.timechk_s,
    required this.gb_i,
    required this.timechk_i,
  });

  // JSON 데이터를 받아 AttendanceData 객체로 파싱
  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      ymd: json['ymd'] ?? "",
      dayname: json['dayname'] ?? "",
      stime: json['stime'] ?? "",
      etime: json['etime'] ?? "",
      gb_s: json['gb_s'] ?? "",
      timechk_s: json['timechk_s'] ?? "",
      gb_i: json['gb_i'] ?? "",
      timechk_i: json['timechk_i'] ?? "",
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