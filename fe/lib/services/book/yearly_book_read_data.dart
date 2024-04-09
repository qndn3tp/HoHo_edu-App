import 'dart:convert';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


////////////////////////
// 연간 독서량 데이터  //
////////////////////////

// 연간 독서량 데이터 가져오는 함수
Future<void> getYearlyBookData() async {
  final UserDataController userDataController = Get.put(UserDataController()); // 유저의 로그인 데이터 컨트롤러
  final DropdownButtonController dropdownButtonController = Get.put(DropdownButtonController()); // 드롭다운버튼 컨트롤러
  final ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());    // 수업정보 컨트롤러

  // 연간 독서량 API URL
  String url = dotenv.get('BOOK_READ_YEAR_TOTAL_URL');

  // 아이디
  final nameIdMap = classInfoDataController.getNameId(classInfoDataController.classInfoDataList);   // 이름: 아이디
  final dropDownId = dropdownButtonController.currentItem.value;                                    // 드롭다운 선택된 이름
  String id = nameIdMap[dropDownId] ?? userDataController.userData!.id;

  // 현재 연도
  String yy = DateFormat('yyyy').format(DateTime(getCurrentYear()));

  // HTTP POST 요청
  var response = await http.post(
    Uri.parse(url), 
    body: {
      'id': id, 
      'yy': yy
    }
  );

  // 응답의 content-type utf-8로 인코딩으로 설정
  if (response.headers['content-type']
          ?.toLowerCase()
          .contains('charset=utf-8') != true) {
    response.headers['content-type'] = 'application/json; charset=utf-8';
  }
  try {
    // 서버로부터 응답을 성공적으로 받았을 때
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      final resultList = json.decode(response.body);

      // 응답 데이터가 성공일 때
      if (resultList[0]["result"] == null) {
        YearBookData yearBookData = YearBookData.fromJson(resultList[0]);                           // 서버로부터 받은 JSON 데이터를 YearBookData 객체리스트로 파싱
        final YearBookDataController yearBookDataController = Get.put(YearBookDataController());     // 연간독서량 컨트롤러를 Get에 등록
        yearBookDataController.setYearBookData(yearBookData);
      }
      // 응답 데이터가 오류일 때("9999": 오류)
      else {
        failDialog1("응답 오류", "독클 결과가 없어요");
      }
    }
  }
  // 서버로부터 응답을 받지 못했을 때
  catch (e) {
    throw Exception('$e');
  }
}