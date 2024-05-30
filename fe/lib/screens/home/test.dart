import 'package:flutter/material.dart';
import 'package:flutter_application/style.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/imagebox_decoration.dart';
import 'package:get/get.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar("월간 리포트"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  border: Border.all(color: const Color.fromARGB(255, 238, 238, 238), width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: 35,
                      height: 35,
                      decoration: imageBoxDecoration("assets/images/smile.png", BoxFit.contain),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1주차", style: TextStyle(fontSize: 18),),
                        Text("배운 단어:")
                      ],
                    )
                  ],
                )
              ),
              const HanReport(),
              const BookReport()
            ],
          ),
        ),
      ),
    );
  }
}


/////////// 
///한스쿨//
//////////
class HanReport extends StatelessWidget {
  const HanReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("한스쿨i", style: TextStyle(fontSize: 20),),
        Container(
          height: 70,
          width: 70,
          decoration: imageBoxDecoration('assets/images/book/img_report_logo1.png', BoxFit.contain),
        ),
        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return weeklyHanResult(index + 1);
          },
        ),
        monthlyHanResult(),
      ],
    );
  }
}

Widget weeklyHanResult(week) {
  return Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: CommonColors.grey3, 
        width: 1, 
      ),
    ),
    child: Row(
      children: [
        // 주차
        Expanded(
          flex: 2,
          child: Center(child: Text("$week주")),
        ),
        // 수직 구분선
        Container(width: 1, color: CommonColors.grey3),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              // 배운 단어
              const SizedBox(height: 50, width: double.infinity, child: Text("배운단어: ")),
              // 수평 구분선
              Container(height: 1, color: CommonColors.grey3),
              // 점수
              const Expanded(
                child: SizedBox(height: 50, width: double.infinity, child: Text("OOO"))),
            ],
          ),
        )
      ],
    ),
  );
}

Widget monthlyHanResult(){
  return Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: CommonColors.grey3, 
        width: 1, 
      ),
    ),
    child: Row(
      children: [
        const Expanded(flex: 3, child: Text("월간평가")),
        // 수직 구분선
        Container(width: 1, color: CommonColors.grey3),
        const Expanded(flex: 7, child: Text("어쩌구저쩌구"))
      ],
    ),
  );
}


/////////////
///북스쿨////
////////////
class BookReport extends StatelessWidget {
  const BookReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("북스쿨i", style: TextStyle(fontSize: 20),),
        Container(
          height: 70,
          width: 70,
          decoration: imageBoxDecoration('assets/images/book/img_report_logo2.png', BoxFit.contain),
        ),
        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return weeklyBookResult(index + 1);
          },
        ),
        writingImage(),
        monthlyBookResult(),
      ],
      );
  }
}

Widget weeklyBookResult(week) {
  return Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: CommonColors.grey3, 
        width: 1, 
      ),
    ),
    child: Row(
      children: [
        // 주차
        Expanded(
          flex: 2,
          child: Center(child: Text("$week주")),
        ),
        // 수직 구분선
        Container(width: 1, color: CommonColors.grey3),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              // 주별 중점내용
              const SizedBox(height: 50, width: double.infinity, child: Text("주별 중점내용")),
              // 수평 구분선
              Container(height: 1, color: CommonColors.grey3),
              // 편지 글쓰기
              const Expanded(
                child: SizedBox(height: 50, width: double.infinity, child: Text("편지 글쓰기"))),
            ],
          ),
        )
      ],
    ),
  );
}

// 이미지
Widget writingImage() {
  return Container(
    height: 100,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
        color: CommonColors.grey3, 
        width: 1, 
      ),
    ),
    child: const Text("한 달간 작성한 글쓰기 중 제일 잘 쓴 페이지 사진 업로드")
  );
}

Widget monthlyBookResult() {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: CommonColors.grey3, width: 1)),
    child: Row(
      children: [
        const Text("월간 평가"),
        scoreContent(),
        scoreContent(),
        scoreContent(),
        scoreContent(),
        const Text("6/8")
      ],
    ),
  );
}

Widget scoreContent() {
  final screenSize = MediaQuery.of(Get.context!).size;
  return Container(
    decoration: const BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: CommonColors.grey3, width: 1))),
    width: screenSize.width / 6,
    height: 50,
    child: Column(
      children: [
        const Expanded(flex: 5, child: Center(child: Text("표현력"))),
        Container(height: 1, color: CommonColors.grey3),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 5, child: Icon(Icons.check_box_outline_blank_rounded, size: 18,)), 
              Container(width: 1, color: CommonColors.grey3),
              const Expanded(flex: 5, child: Icon(Icons.check_box_rounded, size: 18,))
            ],
          ),
        )
      ],
    ),
  );
}