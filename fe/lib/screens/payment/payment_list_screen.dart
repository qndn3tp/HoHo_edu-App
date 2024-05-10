import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/screens/payment/payment_animated_button.dart';
import 'package:flutter_application/screens/payment/payment_cost.dart';
import 'package:flutter_application/screens/payment/payment_info.dart';
import 'package:get/get.dart';
import '../../style.dart';import 'package:flutter/rendering.dart';

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

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.secondary;
    final pointColor = themeController.isLightTheme.value ? LightColors.indigo : DarkColors.indigo;

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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 5,
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
                            Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              activeColor: themeController.isLightTheme.value ? LightColors.green : DarkColors.green,
                              value: isChecked, 
                              onChanged: (value){
                                setState(() {
                                  isChecked = value!;
                                });
                              }
                            ),
                            const Text("2023년 03월 수강료", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            const SizedBox(height: 5),
                          ],
                        ),
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
                        // 결제금액
                        paymentCost("180,000", textColor: textColor, pointColor: pointColor),
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