import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:flutter_application/screens/payment/payment_cost.dart';
import 'package:flutter_application/screens/payment/payment_info.dart';
import 'package:get/get.dart';
import '../../style.dart';

/////////////////
//   결제 내역 //
/////////////////
class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: themeController.isLightTheme.value ? CommonColors.grey2 : DarkColors.basic,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: ((context, index) {
                  // 결제 내용
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value 
                        ? const Color(0xFFfafafa) 
                        : const Color(0xff3c3c3c),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: themeController.isLightTheme.value 
                            ? const Color(0xFFededed) 
                            : const Color(0x00343434), 
                          offset: const Offset(10, 10),
                          blurRadius: 22.0,
                        ),
                        BoxShadow(
                          color: themeController.isLightTheme.value 
                            ? const Color(0xFFFFFFFF) 
                            : const Color(0xff282828), 
                          offset: const Offset(-10, -10),
                          blurRadius: 22,
                        ),
                      ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 날짜
                        const Text("2023년 03월 수강료", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5),
                        // 학생이름
                        paymentInfo("학생 이름", "김호호", textColor: textColor),
                        // 수업명
                        paymentInfo("수업명", "한스쿨i, 북스쿨i", textColor: textColor),
                        // 결제요청일
                        paymentInfo("결제요청일", "2023.02.25", textColor: textColor),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 3,),
                        ),
                        // 결제수단
                        paymentInfo("결제수단", "카드결제", textColor: textColor),
                        // 결제완료일
                        paymentInfo("결제요청일", "2023.02.27 11:00:31", textColor: textColor),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 3,),
                        ),
                        // 결제금액
                        paymentCost("180,000", textColor: textColor, pointColor: textColor),
                      ],
                    ),
                  );
                })
              )
            )
          ],
        ),
      ),
    );
  }
}