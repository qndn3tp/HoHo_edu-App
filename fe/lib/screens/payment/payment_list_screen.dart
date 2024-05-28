import 'package:flutter/material.dart';
import 'package:flutter_application/models/payment_data.dart';
import 'package:flutter_application/widgets/theme_controller.dart';
import 'package:flutter_application/screens/payment/payment_animated_button.dart';
import 'package:flutter_application/screens/payment/payment_cost.dart';
import 'package:flutter_application/screens/payment/payment_info.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../style.dart';import 'package:flutter/rendering.dart';

////////////////////////
//   학원비 결제 화면  //
////////////////////////

// 결제금액 계산 컨트롤러
class PaymentAmountController extends GetxController{
  ////// 받아와야할 api데이터 ///////
  final paymentAmountList = [
    "180000",
    "150000",
    "200000",
    "200000",
  ];
  
  // 개별선택 값
  late RxList<bool> paymentListValue = List<bool>.filled(paymentAmountList.length, false).obs;

  // 개별선택 
  void setPaymentListValue(i) {
    paymentListValue[i] = !paymentListValue[i];
  }

  // 총 금액
  String getTotalAmount() {
    RxInt totalAmount = 0.obs;

    for (int i=0; i<paymentListValue.length; i++) {
      if (paymentListValue[i]) {
        totalAmount += int.parse(paymentAmountList[i]);
      }
    }

    final formatter = NumberFormat('#,###');
    return formatter.format(totalAmount.value);
  }

  // 전체 선택
  void setAllChecked() {
    paymentListValue.fillRange(0, paymentListValue.length, true);
  }

  // 전체 삭제
  void setAllUnChecked() {
    paymentListValue.fillRange(0, paymentListValue.length, false);
  }
}


class PaymentListScreen extends StatefulWidget {
  const PaymentListScreen({super.key});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  bool isChecked = false;
  final themeController = Get.put(ThemeController());
  // 상단 텍스트 스크롤 
  bool _showText = true;
  // 하단바 스크롤 컨트롤러
  bool _showBottomBar = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    // 스크롤 컨트롤러 생성
    _scrollController = ScrollController()..addListener((){
      try {
        // 아래로 스크롤시 상단텍스트, 하단바 숨김
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          setState(() {
            _showBottomBar = false;
            _showText = false;
          });
        } 
        // 위로 스크롤시 상단텍스트,하단바 노출
        else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
          setState(() {
            _showBottomBar = true;
            _showText = true;
          });
        }
    } catch (_) {}
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  //// 받아올 데이터 /////
  final paymentList = [
    PaymentData(date: "202403", name: "김호호", className: "한스쿨i북스쿨i", requestDate: "20240225", amount: "180000"),
    PaymentData(date: "202403", name: "김하하", className: "한스쿨i", requestDate: "20240222", amount: "150000"),
    PaymentData(date: "202403", name: "김후후", className: "북스쿨i", requestDate: "20240227", amount: "200000"),
    PaymentData(date: "202403", name: "김히히", className: "한스쿨i북스쿨i", requestDate: "20240220", amount: "200000"),
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.secondary;
    final pointColor = themeController.isLightTheme.value ? LightColors.indigo : DarkColors.indigo;
    final PaymentAmountController paymentAmountController = Get.put(PaymentAmountController());

    return Scaffold(
      backgroundColor: themeController.isLightTheme.value ? CommonColors.grey2 : DarkColors.basic,
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            // 상단 텍스트
            AnimatedContainer(
              height: _showText ? 20 : 0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                "수강료와 교재비는 함께 결제가 불가능합니다.",
                style: TextStyle(color: textColor, fontSize: 12),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: (){
                    paymentAmountController.setAllChecked();
                  }, 
                  child: const Text("전체 선택", style: TextStyle(color: Colors.black, fontSize: 14))), 
                const Text("|", style: TextStyle(color: Colors.black)),
                TextButton(
                  onPressed: (){
                    paymentAmountController.setAllUnChecked();
                  }, 
                  child: const Text("전체 삭제", style: TextStyle(color: Colors.black, fontSize: 14)))
              ]
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: paymentList.length,
                itemBuilder: ((context, index) {
                  // 결제 내용
                  return Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value 
                        ? const Color(0xFFFFFFFF) 
                        : const Color(0xff3c3c3c),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: themeController.isLightTheme.value 
                            ? const Color(0xFFededed) 
                            : const Color(0xff2e2e2e), 
                          offset: const Offset(10, 10),
                          blurRadius: 22.0,
                        ),
                        BoxShadow(
                          color: themeController.isLightTheme.value 
                            ? const Color(0xFFFFFFFF) 
                            : const Color(0xff292929), 
                          offset: const Offset(-10, -10),
                          blurRadius: 22.0,
                        ),
                      ]),
                    child: Column(
                      children: [
                        // 체크박스, 날짜
                        Row(
                          children: [
                            Obx(() => Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              activeColor: themeController.isLightTheme.value ? LightColors.green : DarkColors.green,
                              value: paymentAmountController.paymentListValue[index], 
                              onChanged: (value){
                                paymentAmountController.setPaymentListValue(index);
                              }
                            )),
                            Text(
                              "${paymentList[index].date.substring(0, 4)}년 ${paymentList[index].date.substring(4)}월 수강료", 
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 5),
                          ],
                        ),
                        // 학생이름
                        paymentInfo("학생 이름", paymentList[index].name, textColor: textColor),
                        // 수업명
                        paymentInfo("수업명", paymentList[index].className, textColor: textColor),
                        // 결제요청일
                        paymentInfo(
                          "결제요청일", 
                          "${paymentList[index].requestDate.substring(0,4)}.${paymentList[index].requestDate.substring(4,6)}.${paymentList[index].requestDate.substring(6)}", 
                          textColor: textColor
                        ),
                        // 구분선
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 3,),
                        ),
                        // 결제금액
                        paymentCost(
                          "${paymentList[index].amount.substring(0,3)},${paymentList[index].amount.substring(3)}", 
                          textColor: textColor, pointColor: pointColor
                        ),
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
      bottomNavigationBar: AnimatedCrossFade(
        firstChild: const BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: PaymentAnimatedButton(),
        ),
        secondChild: const SizedBox.shrink(),
        crossFadeState: _showBottomBar ? CrossFadeState.showFirst : CrossFadeState.showSecond,    // 스크롤 방향에 따라 하단바를 숨김
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}