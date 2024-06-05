import 'dart:convert';
import 'package:flutter_application/models/book_data/first_book_read_date_data.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

////////////////////////////
//  독클 시작 날짜 데이터  //
////////////////////////////

// 독클 시작 날짜 독서 데이터 가져오는 함수
Future<void> getFirstBookReadDateData() async {

  // 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.put(DropdownButtonController()); // 드롭다운 버튼
  final ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());    // 수업정보 
  final LoginDataController loginDataController = Get.put(LoginDataController());                   // 유저의 로그인 데이터

  // 독서클리닉 목록 API URL
  String url = dotenv.get('BOOK_READ_FIRST_DATE_URL');

  // 아이디
  final nameIdMap = classInfoDataController.getNameId(classInfoDataController.classInfoDataList);   // 이름: 아이디
  final dropDownId = dropdownButtonController.currentItem.value;                                    // 드롭다운 선택된 이름
  String stuId = nameIdMap[dropDownId] ?? loginDataController.loginData!.id;

  // HTTP POST 요청
  var response = await http.post(
    Uri.parse(url), 
    body: {
      'stuid': stuId, 
    }
  );

  // 응답의 content-type utf-8로 인코딩으로 설정
  if (response.headers['content-type']
  ?.toLowerCase()
  .contains('charset=utf-8') != true) {
    response.headers['content-type'] = 'application/json; charset=utf-8';
  }
  try {
    // 응답을 성공적으로 받았을 때
    if (response.statusCode == 200) {
      final resultList = json.decode(response.body);

      // 응답 데이터가 성공일 때
      if (resultList[0]["result"] == null) {
        // JSON 데이터를 bookTitleData 객체리스트로 파싱
        BookReadDateData bookReadDateData = BookReadDateData.fromJson(resultList[0]);                          
        final BookReadDateDataController bookReadDateDataController = Get.put(BookReadDateDataController());     
        bookReadDateDataController.setBookReadDateData(bookReadDateData);
      }
      // 응답 데이터가 오류일 때("9999": 오류)
      else {
        failDialog1("응답 오류", "독클 결과가 없어요");
      }
    }
  }
  // 응답을 받지 못했을 때
  catch (e) {
  }
}