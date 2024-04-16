import 'dart:convert';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/widgets/dialog.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/models/login_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

////////////////////////
//  수업 정보, 형제   //
////////////////////////

// 수업정보 가져오는 함수
Future<void> getClassInfo() async {

  final UserDataController userDataController = Get.put(UserDataController()); // 유저의 로그인 데이터 컨트롤러

  // 수업정보 API URL
  String url = dotenv.get('CLASS_INFO_URL');

  // 형제자매 코드
  String sibling = userDataController.userData!.sibling;
  // 현재 연도
  String yy = DateFormat('yyyy').format(DateTime(currentYear));
  String mm = DateFormat('MM').format(DateTime(currentYear, currentMonth));
  // 로그인 아이디
  String loginStuId = userDataController.userData!.id;

  // HTTP POST 요청
  var response = await http.post(
    Uri.parse(url), 
    body: {
      'sibling': sibling, 
      'yy': yy,
      'mm': mm,
      'loginstuid': loginStuId,
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
      print(resultList);

      // 응답 데이터가 성공일 때
      if (resultList[0]["result"] == null) {
        final resultList0 = resultList.cast<Map<String, dynamic>>();
         // 서버로부터 받은 JSON 데이터를 classInfoData 객체리스트로 파싱
        List<ClassInfoData> classInfoDataList = resultList0.map<ClassInfoData>((json) => ClassInfoData.fromJson(json)).toList();
        final ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());     
        classInfoDataController.setClassInfoDataList(classInfoDataList);
      }
      // 응답 데이터가 오류일 때("9999": 오류)
      else {
        failDialog1("응답 오류", "수업정보가 없어요");
      }
    }
  }
  // 서버로부터 응답을 받지 못했을 때
  catch (e) {
    throw Exception('$e');
  }
}