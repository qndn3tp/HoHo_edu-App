import 'package:flutter/material.dart';
import 'package:flutter_application/screens/payment/payment_animated_button.dart';
import 'package:flutter_application/screens/payment/payment_cost.dart';
import 'package:flutter_application/screens/payment/payment_info.dart';
import '../../style.dart' as style;

////////////////////////
//   학원비 결제 화면  //
////////////////////////
class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.LIGHT_GREY,
      body: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            const Center(
              child: Text(
                "수강료와 교재비는 함께 결제가 불가능합니다.",
                style: TextStyle(color: style.DEEP_GREY, fontSize: 12),
              ),
            ),
            const SizedBox(height: 10,),
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
                      color: const Color(0xFFFFFFFF),
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
                      children: [
                        // 체크박스, 날짜
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              // activeColor: style.PRIMARY_BLUE,
                              activeColor: style.PRIMARY_GREEN,
                              value: isChecked, 
                              onChanged: (value){
                                setState(() {
                                  isChecked = value!;
                                });
                              }
                            ),
                            const Text("2023년 03월 수강료", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 5,),
                          ],
                        ),
                        // 학생이름
                        paymentInfo("학생 이름", "김호호"),
                        // 수업명
                        paymentInfo("수업명", "한스쿨i, 북스쿨i"),
                        // 결제요청일
                        paymentInfo("결제요청일", "2023.02.25"),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
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
      // 하단바
      bottomNavigationBar: const BottomAppBar(
        elevation: 0,
        color: style.LIGHT_GREY,
        child: PaymentAnimatedButton(),
      ),
    );
  }
}