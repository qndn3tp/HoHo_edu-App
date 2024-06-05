import 'dart:convert';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/utils/network_check.dart';
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
Future<void> getClassInfoData() async {
  // 컨트롤러
  final LoginDataController loginDataController = Get.put(LoginDataController()); // 유저의 로그인 데이터 컨트롤러
  final ConnectivityController connectivityController = Get.put(ConnectivityController());        // 네트워크 연결체크

  if (connectivityController.isConnected.value) {
    // 수업정보 API URL
    String url = dotenv.get('CLASS_INFO_URL');

    // 형제자매 코드
    String sibling = loginDataController.loginData!.sibling;
    // 현재 연도
    String yy = DateFormat('yyyy').format(DateTime(currentYear));
    String mm = DateFormat('MM').format(DateTime(currentYear, currentMonth));
    // 로그인 아이디
    String stuId = loginDataController.loginData!.id;

    // HTTP POST 요청
    var response = await http.post(
      Uri.parse(url), 
      body: {
        'sibling': sibling, 
        'yy': yy,
        'mm': mm,
        'stuid': stuId,
      }
    );

    // 응답의 content-type utf-8로 인코딩으로 설정
    if (response.headers['content-type']
    ?.toLowerCase().contains('charset=utf-8') != true) {
      response.headers['content-type'] = 'application/json; charset=utf-8';
    }
    try {
      // 응답을 성공적으로 받았을 때
      if (response.statusCode == 200) {
        final resultList = json.decode(response.body);

        // 응답 데이터가 성공일 때
        if (resultList[0]["result"] == null) {
          final resultList0 = resultList.cast<Map<String, dynamic>>();
          // JSON 데이터를 classInfoData 객체리스트로 파싱
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
    // 응답을 받지 못했을 때
    catch (e) {
      throw Exception('$e');
    }
  } else {
    failDialog1("연결 실패", "인터넷 연결을 확인해주세요");
  }
}