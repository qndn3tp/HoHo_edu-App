import 'package:flutter/material.dart';
import 'package:flutter_application/models/notice_data.dart';
import 'package:flutter_application/screens/Notice/Notice_list_tile.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:get/get.dart';

//////////////////////////
// 공지, 수업 상세페이지 //
//////////////////////////

class NoticeDetail extends StatelessWidget {
  final int index; 
  final NoticeDataController noticeDataController = Get.put(NoticeDataController());

  NoticeDetail({super.key, required this.index});

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
              const SizedBox(height: 10),
              const Divider(height: 1),
              // 이미지
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 300,
                color: Colors.deepPurple[100],
                child: const Center(child: Text("이미지")),
              ),
              // 본문
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 300,
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