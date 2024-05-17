import 'package:get/get.dart';  

//////////////////////////////////////////////
//  독서클리닉 영역별 획득 표시(점수) 데이터  //
//////////////////////////////////////////////

// 데이터 클래스
class BookScoreData {
  final String qType;
  final String qTypeName;
  final int qTypeCnt;
  final int jumsu;
  final int per;
  final int ranking;

  BookScoreData ({
  required this.qType,
  required this.qTypeName,
  required this.qTypeCnt,
  required this.jumsu,
  required this.per,
  required this.ranking,
  });
  
  factory BookScoreData.fromJson(Map<String, dynamic> json) {
    return BookScoreData(
      qType: json['Qtype'] ?? "", 
      qTypeName: json['QtypeName'] ?? "", 
      qTypeCnt: json['QtypeCnt'] ?? 0, 
      jumsu: json['jumsu'] ?? 0, 
      per: json['per'] ?? 0, 
      ranking: json['ranking'] ?? 0);
  }
}

// 데이터 컨트롤러
class BookScoreDataController extends GetxController {
  List<BookScoreData>? _bookScoreDataList;

  void setBookScoreDataList(List<BookScoreData> bookScoreDataList) {
    _bookScoreDataList = bookScoreDataList;
    update();
  }

  List<BookScoreData>? get bookScoreDataList => _bookScoreDataList;
  // 영역 개수
  int get scoreCategoryCount => _bookScoreDataList!.length;           

  // 가장 높은 점수의 영역 이름
  String getFirstScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    } 
    // 점수를 기준으로 내림차순 정렬
    _bookScoreDataList!.sort((a,b) => b.per.compareTo(a.per));
    return _bookScoreDataList![0].qTypeName;
  }

  // 두번째로 높은 높은 점수의 영역 이름
  String getSecondScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    }
    return _bookScoreDataList![1].qTypeName;
  }
}