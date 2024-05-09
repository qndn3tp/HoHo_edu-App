import 'package:flutter/material.dart';
import 'package:flutter_application/models/notice_data.dart';
import 'package:flutter_application/screens/Notice/notice_detail_screen.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

/////////////////////////
//  알림장 리스트 타일  //
/////////////////////////

// 알림 색상
List<Color> noticeColorList = [
  const Color(0xff8c8c8c),        // 공지
  const Color(0xff3c46ff),        // 수업
  const Color(0xff0096a0),        // 출석
  const Color(0xffff5a00),        // 결제
  const Color(0xff854fc8),        // 독클
];

// 알림 이미지
List<Image> noticeImageList = [
  Image.asset('assets/images/notice_official.png'),    // 공지
  Image.asset('assets/images/class.png'),              // 수업
  Image.asset('assets/images/attendance.png'),         // 출석
  Image.asset('assets/images/payment.png'),            // 결제
  Image.asset('assets/images/book.png'),               // 독클
];

// 알림 리스트
Widget noticeListTile(context, index) {
  final Size screenSize = MediaQuery.of(context).size;      
  final noticeDataController = Get.put(NoticeDataController());
  final noticeNum = noticeDataController.noticeDataList![index].noticeNum;

  return GestureDetector(
    onTap: () {
      // 공지, 수업 알림은 클릭 시 상세 페이지
      if (noticeNum == 0 || noticeNum == 1) {
        Get.to(
          NoticeDetail(index: index), 
          transition: Transition.cupertino, 
          duration: const Duration(milliseconds: 500)
        );
      }
    },
    child: Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // 이미지
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: noticeColorList[noticeNum], 
              borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(5),
            child: noticeImageList[noticeNum],
          ),
          // 텍스트
          title: Text(
            noticeDataController.noticeDataList![index].title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // 내용
          subtitle: Text(noticeDataController.noticeDataList![index].body),
        ),
        // 알림 시간
        Container(
          margin: EdgeInsets.only(left: screenSize.width * 0.7, bottom: 10),
          height: 25,
          width: screenSize.width * 0.25,
          decoration: BoxDecoration(
            color: style.LIGHT_GREY,
            borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              noticeDataController.noticeDataList![index].ymdTime.split(" ")[0],
              style: const TextStyle(fontSize: 12),))
        ),
        // 구분선
        const Divider(height: 1),
      ],
    ),
  );
}