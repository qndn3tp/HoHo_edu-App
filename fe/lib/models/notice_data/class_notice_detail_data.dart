import 'package:get/get.dart';

/////////////////////////
// 수업안내 상세 데이터 //
/////////////////////////

class ClassNoticeData {
  final String prequest;

  ClassNoticeData({
    required this.prequest
  });

  factory ClassNoticeData.fromJson(Map<String, dynamic> json) {
    return ClassNoticeData(
      prequest: json["prequest"] ?? ""
    );
  }
}

class ClassNoticeDataController extends GetxController {
  ClassNoticeData? _classNoticeData;

  void setClassNoticeData(ClassNoticeData classNoticeData) {
    _classNoticeData = classNoticeData;
    update();
  }
  
  ClassNoticeData? get classNoticeData => _classNoticeData;
}