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