import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/box_decoration.dart';
import 'package:flutter_application/widgets/dropdown_button_controller.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../style.dart' as style;

/////////////////////////////////
// 독클 결과1 (월간 독서리스트) //
/////////////////////////////////

class BookResult1 extends StatefulWidget {
  final int index;
  final String currentPageMonth;

  BookResult1({super.key, required this.index}) : currentPageMonth = DateFormat('yyyy년 M월').format(DateTime(currentYear, index + 1));

  @override
  State<BookResult1> createState() => _BookResult1State();
}

class _BookResult1State extends State<BookResult1> {
  // 컨트롤러
  BookTitleDataController bookTitleDataController = Get.find();       // 책 제목
  DropdownButtonController dropdownButtonController = Get.find();     // 드롭다운 버튼

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height - 200;

    return Column(
      children: [
        SizedBox(height: pageHeight * 0.1,),
        // 텍스트
        Obx(
          () => RichText(
            text: TextSpan(
              children: [
                normalText("${dropdownButtonController.currentItem.value} 학생은 "),
                colorText(widget.currentPageMonth, style.PRIMARY_DEEPBLUE),
                normalText("에"),
              ]),
          ),
        ),
        SizedBox(
          height: pageHeight * 0.15,
          child: RichText(
            text: TextSpan(children: [
              normalText("총 "),
              colorText("${bookTitleDataController.monthlyBookCount}권", style.PRIMARY_DEEPBLUE),
              normalText("의 책을 읽었어요!"),
            ]),
          ),
        ),
        // 독서클리닉 목록(책 제목 리스트)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bookTitleDataController.monthlyBookCount,
          itemBuilder: (context, index) {
            final title = bookTitleDataController.bookTitleDataList?[index].title;
            return Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
              child: Row(
                children: [
                  const Icon(Icons.remove, color: style.DEEP_GREY,),
                  Text(
                    title ?? "",
                    style: const TextStyle(fontSize: 16, color: style.DEEP_GREY),
                  )
                ],
              ),
            );
          },
        ),
        // 이미지, 월간 읽은 책의 권수
        Stack(
          children: [
            // 이미지(배경)
            Container(
              height: 200,
              width: double.infinity,
              decoration: customBoxDecoration1("assets/images/book/b0.png")
            ),
            // 이미지(풍선)
            Positioned(
              left: MediaQuery.of(context).size.width - 120,
              child: Container(
                height: 120,
                width: 120,
                decoration: customBoxDecoration1("assets/images/book/b5.png")
              ),
            ),
            // 월간 읽은 책의 권수
            Positioned(
              left: MediaQuery.of(context).size.width - 95,
              top: 10,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Center(
                  child: Text(
                    "${bookTitleDataController.monthlyBookCount}",
                    style: const TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold,))
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: pageHeight * 0.2,),
      ],
    );
  }
}