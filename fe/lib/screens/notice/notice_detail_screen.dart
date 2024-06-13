import 'package:flutter/material.dart';
import 'package:flutter_application/models/notice_data/class_notice_detail_data.dart';
import 'package:flutter_application/models/notice_data/notice_data.dart';
import 'package:flutter_application/models/notice_data/official_notice_detail_data.dart';
import 'package:flutter_application/screens/Notice/Notice_list_tile.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';

//////////////////////////
// 공지, 수업 상세페이지 //
//////////////////////////

class NoticeDetailScreen extends StatelessWidget {
  final int index; 
  final int noticeNum;  // 알림 구분 값(공지:0, 수업:1)
  final NoticeDataController noticeDataController = Get.put(NoticeDataController());
  final OfficialNoticeDataController officialNoticeDataController = Get.put(OfficialNoticeDataController());
  final ClassNoticeDataController classNoticeDataController = Get.put(ClassNoticeDataController());

  NoticeDetailScreen({super.key, required this.index, required this.noticeNum});

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
              const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1)),
              // 본문
              noticeNum == 0
              // 공지 내용 상세
              ? Column(
                children: [
                  // 이미지
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 300, 
                    width: double.infinity, 
                    child: Image.network(
                      officialNoticeDataController.officialNoticeData!.imageUrl, 
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
                    officialNoticeDataController.officialNoticeData!.content,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              )
              // 수업 내용 상세
              : Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  classNoticeDataController.classNoticeData!.prequest,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}