import 'package:get/get.dart';  

////////////////////////////////////
//  로그인시 받아온 유저의 데이터  //
///////////////////////////////////

// 유저의 로그인 데이터 클래스
class UserData {
  final String id;
  final String name;
  final String cid;
  final String cname;
  final String brotherGb;
  final String sibling;

  UserData({
    required this.id,
    required this.name,
    required this.cid,
    required this.cname,
    required this.brotherGb,
    required this.sibling,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      cid: json['cid'] ?? "",
      cname: json['cname'] ?? "",
      brotherGb: json['brotherGb'] ?? "",
      sibling: json['sibling'] ?? "",
    );
  }
}

// 유저의 로그인 데이터 컨트롤러
class UserDataController extends GetxController {
  UserData? _userData;           

  void setUserData(UserData userData) {
    _userData = userData;
    update();
  }

  UserData? get userData => _userData;
}