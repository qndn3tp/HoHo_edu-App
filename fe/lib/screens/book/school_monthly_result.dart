import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/dashed_divider.dart';
import 'package:get/get.dart';

Widget monthlyReportResult(String title) {
  final hanResultTitle = ["한자 습득", "어휘 활용", "의미 이해", "문장 적용"];
  final bookResultTitle = ["표현력", "사고력", "추론력", "분석력"];

  final hanScore = [2,1,1,0];
  final bookScore = [1,2,0,1];

  final resultTitle = title == "han" ? hanResultTitle : bookResultTitle;
  final score = title == "han" ? hanScore : bookScore;

  return Container(
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 80),
    height: 90,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Stack(
      children: [
        Column(
          children: [
            // 결과 제목
            Expanded(
              flex: 4,
              child: Container(
                height: 35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff868ad6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => Center(
                      child: Text(
                        resultTitle[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "NotoSansKR-SemiBold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 결과 내용(체크박스)
            Expanded(
              flex: 6,
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      height: 45,
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: score[index] >= 1 ? const Color(0xff868ad6) : Colors.white,
                              border: Border.all(
                                color: const Color(0xff868ad6),
                                width: 2,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: score[index] >= 2 ? const Color(0xff868ad6) : Colors.white,
                              border: Border.all(
                                color: const Color(0xff868ad6),
                                width: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // 수직 점선 구분선
        for (int i = 1; i < 4; i++)
          Positioned(
            top: 0,
            bottom: 0,
            left: (MediaQuery.of(Get.context!).size.width - 40) * i / 4,
            child: const DashedVerticalDivider()
          ),
      ],
    ),
  );
}