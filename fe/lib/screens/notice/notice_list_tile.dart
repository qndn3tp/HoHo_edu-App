import 'package:flutter/material.dart';

/////////////////////////
//  알림장 리스트 타일  //
/////////////////////////

// 알림 색상
List<Color> noticeColorList = [
  const Color(0xff3c46ff), // 수업안내
  const Color(0xffff5a00), // 학원비 알림
  const Color(0xff0096a0), // 출석 알림
  const Color(0xff854fc8), // 독클결과 알림
  const Color(0xff8c8c8c), // 공지사항
];

// 알림 이미지
List<Image> noticeImageList = [
  Image.asset('assets/images/main_profile_status_on.png'), // 수업안내
  Image.asset('assets/images/menu_payment.png'), // 학원비 알림
  Image.asset('assets/images/menu_attendance.png'), // 출석 알림
  Image.asset('assets/images/book.png'), // 독클결과 알림
  Image.asset('assets/images/menu_notice_official.png'), // 공지사항
];


// 알림 리스트
Widget noticeListTile(context) {
  final Size screenSize = MediaQuery.of(context).size;      // 기기의 화면사이즈

  return Column(
    children: [
      ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(5),
          child: Image.asset('assets/images/main_profile_status_on.png'),
        ),
        title: const Text(
          '수업안내',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('안녕하세요 호호서당입니다'),
        onTap: () {},
      ),
      // 알림 시간
      Container(
        margin: EdgeInsets.only(left: screenSize.width * 0.6, bottom: 10),
        height: 20,
        width: screenSize.width * 0.3,
        decoration: BoxDecoration(
            color: const Color(0xfff2f2f2),
            borderRadius: BorderRadius.circular(20)),
      ),
      // 구분선
      const Divider(
        height: 1,
      ),
    ],
  );
}