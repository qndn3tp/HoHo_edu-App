import 'package:flutter/material.dart';
import 'package:flutter_application/models/book_data.dart';
import 'package:flutter_application/utils/get_current_date.dart';
import 'package:flutter_application/widgets/text_span.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../style.dart' as style;

///////////////////////////////////
// 독서클리닉 결과3 (연간) //
///////////////////////////////////

class BookResult3 extends StatefulWidget {
  const BookResult3({super.key});

  @override
  State<BookResult3> createState() => _BookResult3State();
}

class _BookResult3State extends State<BookResult3> {

  // 컨트롤러
  YearBookDataController yearBookDataController = Get.put(YearBookDataController());

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            RichText(text: normalText("${DateFormat('yyyy년 M월').format(DateTime(currentYear, 1))}부터 ${DateFormat('yyyy년 M월').format(DateTime(currentYear, currentMonth))}까지")),
            // 연간 읽은 책의 권수
            RichText(
              text: TextSpan(children: [
                colorText("총 ${yearBookDataController.yearBookData!.total_rows}권", style.PRIMARY_GREEN),
                normalText("의 책을 읽었어요"),
              ])
            ),
            const SizedBox(
              height: 50,
            )
          ],
        );
  }
}