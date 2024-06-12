import 'package:flutter/material.dart';
import 'package:flutter_application/models/notice_data/notice_data.dart';
import 'package:flutter_application/models/notice_data/official_notice_detail_data.dart';
import 'package:flutter_application/screens/Notice/Notice_list_tile.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';

/////////////////////
// 수업 상세페이지 //
////////////////////

class OfficialDetailScreen_ extends StatelessWidget {
  final int index; 
  final NoticeDataController noticeDataController = Get.put(NoticeDataController());
  final OfficialDataController officialDataController = Get.put(OfficialDataController());

  OfficialDetailScreen_({super.key, required this.index});

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
                children: [
                  // 알림 이미지
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: lightNoticeColorList[noticeDataController.noticeDataList![index].noticeNum], 
                      borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(5),
                    child: noticeImageList[noticeDataController.noticeDataList![index].noticeNum], 
                  ),
                  // 알림 제목
                  Text(
                    noticeDataController.noticeDataList![index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
              // 구분선
              const Padding(padding: EdgeInsets.symmetric(vertical: 10),child: Divider(height: 1)),
              // 본문
              Column(
                children: [
                  // 이미지
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 300, 
                    width: double.infinity, 
                    color: Colors.amber, 
                    child: Image.network(
                      officialDataController.officialNoticeData!.imageUrl, 
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text('이미지를 불러올 수 없어요.'),
                        );
                      }
                    )
                  ),
                  // 글
                  Text(
                    officialDataController.officialNoticeData!.content,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}