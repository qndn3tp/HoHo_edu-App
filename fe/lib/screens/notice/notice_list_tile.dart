import 'package:flutter/material.dart';
import 'package:flutter_application/utils/get_current_date.dart';

/////////////////////////
//  알림장 리스트 타일  //
/////////////////////////

// 알림 텍스트
List noticeTitleList = [
  "공지사항",
  "수업 안내",
  "출석 알림",
  "결제 알림",
  "독클 결과",
];

// 알림 색상
List<Color> noticeColorList = [
  const Color(0xff8c8c8c), // 공지 알림
  const Color(0xff3c46ff), // 수업 알림
  const Color(0xff0096a0), // 출석 알림
  const Color(0xffff5a00), // 결제 알림
  const Color(0xff854fc8), // 독클 알림
];

// 알림 이미지
List<Image> noticeImageList = [
  Image.asset('assets/images/menu_notice_official.png'),    // 공지 알림
  Image.asset('assets/images/main_profile_status_on.png'),  // 수업 알림
  Image.asset('assets/images/menu_attendance.png'),         // 출석 알림
  Image.asset('assets/images/menu_payment.png'),            // 결제 알림
  Image.asset('assets/images/book.png'),                    // 독클 알림
];


// 알림 리스트
Widget noticeListTile(context) {
  final Size screenSize = MediaQuery.of(context).size;      // 기기의 화면사이즈

  // 알림 내용
  const noticeBody = '안녕하세요 호호서당입니다. 김호호 학생의 이번 주 수업을 안내해 드립니다. 수업교실ㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂ';

  String truncate(string) {
    if (string.length >= 45) {
      return string.substring(0, 45) + "...";
    }
    return string;
  }
  
  return Column(
    children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: noticeColorList[1], borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: noticeImageList[1],
        ),
        title: Text(
          noticeTitleList[1],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(truncate(noticeBody)),
        onTap: () {},
      ),
      // 알림 시간
      Container(
        margin: EdgeInsets.only(left: screenSize.width * 0.6, bottom: 10),
        height: 25,
        width: screenSize.width * 0.3,
        decoration: BoxDecoration(
            color: const Color(0xfff2f2f2),
            borderRadius: BorderRadius.circular(20)),
        child: Center(child: Text(getCurrentDateTime(), style: const TextStyle(fontSize: 12),))
      ),
      // 구분선
      const Divider(
        height: 1,
      ),
    ],
  );
}