import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/screens/book/book_score_indicator.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

///////////////////////////////////
// 독서클리닉 결과2 (분야별 점수) //
///////////////////////////////////

class BookResult2 extends StatefulWidget {
  const BookResult2({super.key});

  @override
  State<BookResult2> createState() => _BookResult2State();
}

class _BookResult2State extends State<BookResult2> {
  
  // 컨트롤러
  BookScoreDataController bookScoreDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
          children: [
            // 텍스트
            RichText(
              text: TextSpan(
                children: [
                  normalText("위의 책을 읽고 "),
                  colorText(bookScoreDataController.getFirstScoreName(), style.PRIMARY_ORANGE),  // 가장 점수가 높은 영역
                  normalText(", "),
                  colorText(bookScoreDataController.getSecondScoreName(), style.PRIMARY_ORANGE), // 가장 점수가 낮은 영역
                  normalText(" 능력이"),
                ]
              )
            ),
            RichText(text: normalText("풍부해졌어요."),),
            const SizedBox(
              height: 20,
            ),
            // 이미지
            Image.asset("assets/images/menu_book_report2.png"),
            // 각 영역별 점수 표시(가로배치) 
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),  
              childAspectRatio: 5 / 1,                        // 각 그리드의 가로/세로 비율
              children: List.generate(
                bookScoreDataController.scoreCategoryCount,   // 아이템 개수
                (index) {
                  // 각 영역별 점수
                  return Container(
                    margin: EdgeInsets.only(left: screenSize.width * 0.05),
                    child: scoreIndicator(context, index),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
  }
}