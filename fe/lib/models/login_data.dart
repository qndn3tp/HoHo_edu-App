import 'package:get/get.dart';  

////////////////////////////////////
//  로그인시 받아온 유저의 데이터  //
///////////////////////////////////

// 데이터 클래스
class LoginData {
  final String id;             // 학생 아이디
  final String cname;          // 센터 이름
  final String sibling;        // 형제 코드

  LoginData({
    required this.id,
    required this.cname,
    required this.sibling,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['stuid'] ?? "",
      cname: json['cname'] ?? "",
      sibling: json['sibling'] ?? "",
    );
  }
}

// 데이터 컨트롤러
class LoginDataController extends GetxController {
  LoginData? _loginData;           

  void setLoginData(LoginData loginData) {
    _loginData = loginData;
    update();
  }

  LoginData? get loginData => _loginData;
}