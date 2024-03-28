import 'package:get/get.dart';  

///////////////////////////////////
//  독서클리닉 데이터, 컨트롤러   //
///////////////////////////////////

//  연간 독서량 데이터 클래스
class YearBookData {
  final int total_rows;

  YearBookData({
    required this.total_rows,
  });

  // JSON 데이터를 받아 YearBookData 객체로 파싱
  factory YearBookData.fromJson(Map<String, dynamic> json) {
    return YearBookData(
      total_rows: json['total_rows'] ?? "",
    );
  }
}
// 연간 독서량 데이터 컨트롤러
class YearBookDataController extends GetxController {
  YearBookData? _yearBookData;            // YearBookData의 객체 _yearBookData 선언

  // _yearBookData를 받아온 YearBookData 객체로 설정
  void setYearBookData(YearBookData yearBookData) {
    _yearBookData = yearBookData;
    update();
  }

  // getter()함수: userData
  YearBookData? get yearBookData => _yearBookData;
}



// 독서클리닉 목록(책 제목) 데이터 클래스
class BookTitleData {
  final String book_gubun;
  final String title;
  
  BookTitleData({
    required this.book_gubun,
    required this.title,
  });

  // JSON 데이터를 받아 BookTitleData 객체로 파싱
  factory BookTitleData.fromJson(Map<String, dynamic> json) {
    return BookTitleData(
      book_gubun: json['book_gubun'] ?? "",
      title: json['title'] ?? "",
    );
  }
}
// 독서클리닉 목록 데이터 컨트롤러
class BookTitleDataController extends GetxController {
  List<BookTitleData>? _bookTitleDataList;

  void setBookTitleDataList(List<BookTitleData> bookTitleDataList) {
    _bookTitleDataList = bookTitleDataList;
    update();
  }

  List<BookTitleData>? get bookTitleDataList => _bookTitleDataList;
  int get monthlyBookCount => _bookTitleDataList!.length;            // 월간 독서량
}


// 독서클리닉 영역별 획득 표시(점수) 데이터 클래스
class BookScoreData {
  final String Qtype;
  final String QtypeName;
  final int QtypeCnt;
  final int jumsu;
  final int per;
  final int ranking;

  BookScoreData ({
  required this.Qtype,
  required this.QtypeName,
  required this.QtypeCnt,
  required this.jumsu,
  required this.per,
  required this.ranking,
  });
  
  // JSON 데이터를 받아 BookScoreData 객체로 파싱
  factory BookScoreData.fromJson(Map<String, dynamic> json) {
    return BookScoreData(
      Qtype: json['Qtype'] ?? "", 
      QtypeName: json['QtypeName'] ?? "", 
      QtypeCnt: json['QtypeCnt'] ?? 0, 
      jumsu: json['jumsu'] ?? 0, 
      per: json['per'] ?? 0, 
      ranking: json['ranking'] ?? 0);
  }
}

// 독서클리닉 영역별 획득 표시(점수) 데이터 컨트롤러
class BookScoreDataController extends GetxController {
  List<BookScoreData>? _bookScoreDataList;

  void setBookScoreDataList(List<BookScoreData> bookScoreDataList) {
    _bookScoreDataList = bookScoreDataList;
    update();
  }

  List<BookScoreData>? get bookScoreDataList => _bookScoreDataList;
  int get scoreCategoryCount => _bookScoreDataList!.length;           // 영역 개수

  // 가장 높은 점수의 영역 이름을 가져온다
  String getFirstScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    } 
    // 점수를 기준으로 내림차순 정렬해서 표시
    _bookScoreDataList!.sort((a,b) => b.per.compareTo(a.per));
    return _bookScoreDataList![0].QtypeName;
  }

  // 두번째로 높은 높은 점수의 영역 이름을 가져온다
  String getSecondScoreName() {
    if (_bookScoreDataList == null || scoreCategoryCount == 0) {
      return "";
    }
    return _bookScoreDataList![1].QtypeName;
  }
}

