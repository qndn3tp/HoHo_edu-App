import 'dart:math';
import 'package:get/get.dart';  

///////////////////////////////////
//  연간독서량 데이터, 컨트롤러   //
///////////////////////////////////
// 데이터 클래스
class YearBookData {
  final int totalRows;

  YearBookData({
    required this.totalRows,
  });

  // JSON 데이터를 받아 YearBookData 객체로 파싱
  factory YearBookData.fromJson(Map<String, dynamic> json) {
    return YearBookData(
      totalRows: json['total_rows'] ?? "",
    );
  }
}
//데이터 컨트롤러
class YearBookDataController extends GetxController {
  YearBookData? _yearBookData;           

  // _yearBookData를 받아온 YearBookData 객체로 설정
  void setYearBookData(YearBookData yearBookData) {
    _yearBookData = yearBookData;
    update();
  }
  YearBookData? get yearBookData => _yearBookData;
}

///////////////////////////////////////
//  독서클리닉 목록 데이터, 컨트롤러   //
///////////////////////////////////////
// 데이터 클래스
class BookTitleData {
  final String bookGubun;
  final String title;
  
  BookTitleData({
    required this.bookGubun,
    required this.title,
  });

  factory BookTitleData.fromJson(Map<String, dynamic> json) {
    return BookTitleData(
      bookGubun: json['book_gubun'] ?? "",
      title: json['title'] ?? "",
    );
  }
}
// 데이터 컨트롤러
class BookTitleDataController extends GetxController {
  List<BookTitleData>? _bookTitleDataList;

  void setBookTitleDataList(List<BookTitleData> bookTitleDataList) {
    _bookTitleDataList = bookTitleDataList;
    update();
  }

  List<BookTitleData>? get bookTitleDataList => _bookTitleDataList;
  int get monthlyBookCount => _bookTitleDataList!.length;            // 월간 독서량
}

/////////////////////////////////////////////////////////
//  독서클리닉 영역별 획득 표시(점수) 데이터, 컨트롤러   //
////////////////////////////////////////////////////////
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

  // 가장 높은 점수의 영역 이름을 가져온다
  String getFirstScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    } 
    // 점수를 기준으로 내림차순 정렬해서 표시
    _bookScoreDataList!.sort((a,b) => b.per.compareTo(a.per));
    return _bookScoreDataList![0].qTypeName;
  }

  // 두번째로 높은 높은 점수의 영역 이름을 가져온다
  String getSecondScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    }
    return _bookScoreDataList![1].qTypeName;
  }
}


/////////////////////////////////////////////////////////
//  독서클리닉 영역별 획득 표시(점수) 데이터, 컨트롤러   //
////////////////////////////////////////////////////////
// 데이터 클래스
class YMBookCountData {
  final String month;
  final int count;
  
  YMBookCountData({
    required this.month,
    required this.count,
  });

  factory YMBookCountData.fromJson(Map<String, dynamic> json) {
    return YMBookCountData(
      month: json['Month'] ?? "",
      count: json['Count'] ?? 0,
    );
  }
}
// // 데이터 컨트롤러
class YMBookCountDataController extends GetxController {
  List<YMBookCountData>? _ymBookCountDataList;

  final currentMonth = DateTime.now().month;      // 현재 달
  late List<int> bookCountList;                   // 월별 독서량 리스트
  late int maxReadCount;                          // 독서량 최대값
  late int maxReadMonth;                          // 독서량 최대값인 달
  late String meanReadCount;                      // 독서량 평균값
  late List<double> meanCountList;                // 평균 독서량 리스트

  void setYMBookCountDataList(List<YMBookCountData> ymBookCountDataList) {
    _ymBookCountDataList = ymBookCountDataList;
    setBookChartData();
    update();
  }

  // 독서 차트 데이터
  void setBookChartData() {
    if (_ymBookCountDataList != null) {
      bookCountList = [];
      for (int i = 0; i < 12; i++) {
        bookCountList.add(_ymBookCountDataList![i].count);
      }
      maxReadCount = bookCountList.reduce(max);
      maxReadMonth = bookCountList.indexOf(maxReadCount) + 1;
      meanReadCount = (bookCountList.sublist(0, currentMonth)
              .reduce((value, element) => value + element) / currentMonth).toStringAsFixed(1);
      meanCountList = List.filled(currentMonth, double.parse(meanReadCount)) +
          List.filled(12 - currentMonth, 0.toDouble());
    }
  }
}
