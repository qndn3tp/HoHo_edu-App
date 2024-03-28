import 'package:connectivity_plus/connectivity_plus.dart';

///////////////////////////////
// 로그인 네트워크 연결 체크 //
/////////////////////////////

Future<bool> connectivityCheck() async{
  // 네트워크 연결 체크
  var connectivityResult = await(Connectivity().checkConnectivity());    
  // 모바일데이터나 와이파이에 연결된 경우
  if (connectivityResult == ConnectivityResult.mobile                     
      || connectivityResult == ConnectivityResult.wifi) {
      return true;
  }
  // 네트워크가 연결되지 않은 경우 알림  
  else {                                                                  
    return false;
  }
}