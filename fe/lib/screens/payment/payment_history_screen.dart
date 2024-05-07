import 'package:flutter/material.dart';
import 'package:flutter_application/screens/payment/payment_cost.dart';
import 'package:flutter_application/screens/payment/payment_info.dart';
import '../../style.dart' as style;

/////////////////
//   결제 내역 //
/////////////////
class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.LIGHT_GREY,
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
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFFfafafa),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFededed),
                          offset: Offset(10, 10),
                          blurRadius: 22,
                        ),
                        BoxShadow(
                          color: Color(0xFFFFFFFF),
                          offset: Offset(-10, -10),
                          blurRadius: 22,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 날짜
                        const Text("2023년 03월 수강료", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5),
                        // 학생이름
                        paymentInfo("학생 이름", "김호호"),
                        // 수업명
                        paymentInfo("수업명", "한스쿨i, 북스쿨i"),
                        // 결제요청일
                        paymentInfo("결제요청일", "2023.02.25"),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 3,),
                        ),
                        // 결제수단
                        paymentInfo("결제수단", "카드결제"),
                        // 결제완료일
                        paymentInfo("결제요청일", "2023.02.27 11:00:31"),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 3,),
                        ),
                        // 결제금액
                        paymentCost("180,000"),
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