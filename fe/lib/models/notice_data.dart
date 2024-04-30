import 'package:get/get.dart';  

/////////////////////////////
//  알림 데이터, 컨트롤러   //
/////////////////////////////

// 알림 데이터 클래스
class NoticeData {
  final String title;
  final String body;
  final int noticeNum;
  final String ymdTime;
  final String ymd;
  final String teacherId;
  final String sTime;
  final String subjectGb;
  final String stuId2;

  NoticeData({
    required this.title,
    required this.body,
    required this.noticeNum,
    required this.ymdTime,
    required this.ymd,
    required this.teacherId,
    required this.sTime,
    required this.subjectGb,
    required this.stuId2,
  });

  // JSON 데이터를 받아 NoticeData 객체로 파싱
  factory NoticeData.fromJson(Map<String, dynamic> json) {
    return NoticeData(
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      noticeNum: json['noticeNum'] ?? 0,
      ymdTime: json['ymdtime'] ?? "",
      ymd: json['ymd'] ?? "",
      teacherId: json['teaid'] ?? "",
      sTime: json['stime'] ?? "",
      subjectGb: json['sgb'] ?? "",
      stuId2: json['stuid2'] ?? "",
    );
  }
}
// 알림 데이터 컨트롤러
class NoticeDataController extends GetxController {
  List<NoticeData>? _noticeDataList;

  void setNoticeDataList(List<NoticeData> noticeDataList) {
    _noticeDataList = noticeDataList;
    update();
  }

  List<NoticeData>? get noticeDataList => _noticeDataList;
}
