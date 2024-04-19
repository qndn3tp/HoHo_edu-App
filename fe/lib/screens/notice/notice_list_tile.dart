import 'package:flutter/material.dart';
import 'package:flutter_application/models/notice_data.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../style.dart' as style;

/////////////////////////
//  알림장 리스트 타일  //
/////////////////////////

// 알림 색상
List<Color> noticeColorList = [
  const Color(0xff8c8c8c),        // 공지 알림
  const Color(0xff3c46ff),        // 수업 알림
  const Color(0xff0096a0),        // 출석 알림
  const Color(0xffff5a00),        // 결제 알림
  const Color(0xff854fc8),        // 독클 알림
];
// 알림 이미지
List<Image> noticeImageList = [
  Image.asset('assets/images/notice_official.png'),    // 공지 알림
  Image.asset('assets/images/class.png'),              // 수업 알림
  Image.asset('assets/images/attendance.png'),         // 출석 알림
  Image.asset('assets/images/payment.png'),            // 결제 알림
  Image.asset('assets/images/book.png'),               // 독클 알림
];


// 알림 리스트
Widget noticeListTile(context, index) {
  final noticeDataController = Get.put(NoticeDataController());
  final Size screenSize = MediaQuery.of(context).size;      
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
        const Divider(
          height: 1,
        ),
      ],
    ),
  );
}



// 공지, 수업 상세페이지
class NoticeDetail extends StatelessWidget {
  final int index; 

  NoticeDetail({super.key, required this.index});

  final NoticeDataController noticeDataController = Get.put(NoticeDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("알림장"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 알림 제목
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: noticeColorList[noticeDataController.noticeDataList![index].noticeNum], // noticeNum이 어디서 오는지 모르겠습니다.
                      borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(5),
                    child: noticeImageList[noticeDataController.noticeDataList![index].noticeNum], // noticeNum이 어디서 오는지 모르겠습니다.
                  ),
                  Text(
                    noticeDataController.noticeDataList![index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10,),
              const Divider(
                height: 1,
              ),
              // 이미지
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 400,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("이미지")),
              ),
              // 본문
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 400,
                color: Colors.amber[100],
                child: const Center(child: Text("본문")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
