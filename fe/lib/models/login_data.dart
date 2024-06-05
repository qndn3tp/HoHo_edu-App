import 'package:get/get.dart';  

////////////////////////////////////
//  로그인시 받아온 유저의 데이터  //
///////////////////////////////////

// 유저의 로그인 데이터 클래스
class LoginData {
  final String id;
  final String name;
  final String cid;
  final String cname;
  final String brotherGb;
  final String sibling;
  final String isFirstLogin;

  LoginData({
    required this.id,
    required this.name,
    required this.cid,
    required this.cname,
    required this.brotherGb,
    required this.sibling,
    required this.isFirstLogin,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['stuid'] ?? "",
      name: json['name'] ?? "",
      cid: json['cid'] ?? "",
      cname: json['cname'] ?? "",
      brotherGb: json['brotherGb'] ?? "",
      sibling: json['sibling'] ?? "",
      isFirstLogin: json['firstLogin'] ?? "",
    );
  }
}

// 유저의 로그인 데이터 컨트롤러
class LoginDataController extends GetxController {
  LoginData? _loginData;           

  void setLoginData(LoginData loginData) {
    _loginData = loginData;
    update();
  }

  LoginData? get loginData => _loginData;
}