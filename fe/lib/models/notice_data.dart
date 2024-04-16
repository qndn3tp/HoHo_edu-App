import 'package:get/get.dart';  

/////////////////////////////
//  알림 데이터, 컨트롤러   //
/////////////////////////////


// 알림 데이터 클래스
class NoticeData {
  final String title;
  final String body;
  final int index;
  final String time;

  NoticeData({
    required this.title,
    required this.body,
    required this.index,
    required this.time,
  });

  // JSON 데이터를 받아 NoticeData 객체로 파싱
  factory NoticeData.fromJson(Map<String, dynamic> json) {
    return NoticeData(
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      index: json['index'] ?? 0,
      time: json['time'] ?? "",
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
