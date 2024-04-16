import 'package:flutter/material.dart';
import 'package:flutter_application/models/class_info_data.dart';
import 'package:flutter_application/screens/home/home_menu_box.dart';
import 'package:flutter_application/screens/home/home_student_info_box.dart';
import 'package:flutter_application/widgets/app_bar_drawer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../models/login_data.dart';
import 'package:banner_carousel/banner_carousel.dart';
import '../../style.dart' as style;

///////////////////
//    홈 화면    //
///////////////////

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 유저의 로그인 데이터 정보
  final UserDataController userDataController = Get.put(UserDataController());

  // 스크롤 컨트롤러 생성
  final ScrollController scrollController = ScrollController();

  // 수업 정보 데이터 컨트롤러
  final ClassInfoDataController classInfoDataController = Get.put(ClassInfoDataController());

  // 로딩값
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 500), () {        // 500 milliseconds 동안 로딩바 표시
      setState(() {
      isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    // 현재 화면의 크기 (기기별 화면 크기를 받아옴)
    final Size screenSize = MediaQuery.of(context).size;

    // 형제자매 이름 리스트
    List<String> snamesList = classInfoDataController.getSnamesList(classInfoDataController.classInfoDataList);

    // 수업정보 박스
    List<Widget> banners = [];
    for (int i = 0; i < snamesList.length; i++) {         // 학생 수만큼 반복하여 banners에 studentInfoBox 추가
      final name = snamesList[i];
      banners.add(studentInfoBox(context, name));
    }

    return isLoading 
    ? 
    // 로딩화면
    Container(
      decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
      child: const SpinKitThreeBounce(color: style.LIGHT_GREY),
    )
    : 
    // 로딩 후 화면
    Container(
        // 홈 배경화면
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        // 홈 Content
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Image.asset('assets/images/appbar/appbar_logo.png'),
            backgroundColor: const Color(0xfffffde3),
            elevation: 0,
          ),
          // 앱 바의 사이드 메뉴
          endDrawer: appbarDrawer(context),
          // 바디
          body: Center(
            child: Column(
              children: [
                // 빈칸
                SizedBox(
                  height: (screenSize.height * 0.1),
                ),
                // 학생 정보 박스(이름, 센터, 수강정보)
                BannerCarousel(
                  customizedIndicators: const IndicatorModel.animation(width: 10, height: 5, spaceBetween: 2, widthAnimation: 30),
                  activeColor: Colors.white70,
                  disableColor: Colors.white38,
                  animation: true,
                  width: screenSize.width * 0.9,
                  height: screenSize.width * 0.45,
                  indicatorBottom: false,
                  customizedBanners: banners,
                ),
                const SizedBox(
                  height: 30,
                ),
                // 메뉴 박스(출석체크, 학원비 납부, 알림장, 독클결과)
                menuBox(screenSize),
              ],
            ),
          ),
        ),
    );
  }
}

