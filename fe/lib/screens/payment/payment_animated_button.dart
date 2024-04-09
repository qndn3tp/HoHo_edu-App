import 'package:flutter/material.dart';
import '../../style.dart' as style;

//////////////////
//   결제 버튼  //
//////////////////

class PaymentAnimatedButton extends StatefulWidget {
  const PaymentAnimatedButton({super.key});

  @override
  State<PaymentAnimatedButton> createState() => _PaymentAnimatedButtonState();
}

class _PaymentAnimatedButtonState extends State<PaymentAnimatedButton> with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러 
  late AnimationController _animationController;      

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 생성
    _animationController = AnimationController(
      vsync: this,                
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,                             // 애니메이션 범위: 하한값
      upperBound: 0.1,                             // 애니메이션 범위: 상한가
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;          // 축소,확대 규모

    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _animationController.forward();                     // 애니메이션 시작: 현재값 -> 상한값
      },
      onPointerUp: (PointerUpEvent event) {
        _animationController.reverse();                     // 애니메이션 역방향: 현재값 -> 하한값
      },

      // child 요소의 크기를 변경
      child: Transform.scale(
        scale: scale,
        // 결제 버튼
        child: Container(
          decoration: BoxDecoration(
            color: style.PRIMARY_BLUE,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 5.0,
                spreadRadius: 0.25,
              ),
            ],
          ),
          child: Center(
            // 결제 텍스트
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "총 ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "360,000",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffffd91c))),
                    TextSpan(
                      text: "원 결제",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ]
                ),
              )
          ),
        ),
      ),
    );
  }
}
