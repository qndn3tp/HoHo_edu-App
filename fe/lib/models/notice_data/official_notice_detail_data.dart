import 'package:get/get.dart';

/////////////////////////
// 공지안내 상세 데이터 //
/////////////////////////

// 데이터 클래스
class OfficialNoticeData {
  final String title;
  final String content;
  final String imageFile;
  final String year;
  final String imageUrl;

  OfficialNoticeData({
    required this.title,
    required this.content,
    required this.imageFile,
    required this.year,
    required this.imageUrl,
  });

  factory OfficialNoticeData.fromJson(Map<String, dynamic> json) {
    return OfficialNoticeData(
      title: json["title"] ?? "",
      content: json["note"] ?? "",
      imageFile: json["addfile"] ?? "",
      year: json["yy"] ?? "",
      imageUrl: json["url"] ?? "",
    );
  }
}

// 데이터 컨트롤러
class OfficialNoticeDataController extends GetxController {
  OfficialNoticeData? _officialNoticeData;

  void setOfficialNoticeData(OfficialNoticeData officialNoticeData) {
    _officialNoticeData = officialNoticeData;
    update();
  }
  
  OfficialNoticeData? get officialNoticeData => _officialNoticeData;
}