import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;
import './payment_animated_button.dart';

////////////////////////
//   학원비 납부 화면  //
////////////////////////

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단바
      appBar: AppBar(
        // 뒤로가기 버튼(홈으로 이동)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "학원비 납부",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.offAll(const HomeScreen()),
            child: Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              height: 22,
              width: 22,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_home.png'),
                    fit: BoxFit.contain),
              ),
            ),
          ),
        ],
        // TabBar
        bottom: TabBar(
          /// style
          dividerColor: Colors.transparent,
          indicatorColor: style.PRIMARY_DEEPBLUE,
          labelColor: style.PRIMARY_DEEPBLUE,
          unselectedLabelColor: style.GREY,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return Colors.transparent; // 선택되지 않은 탭 위에는 투명한 색상 적용
          }),
          ///
          controller: _tabController,
          tabs: const [
            Tab(text: '학원비 결제'),
            Tab(text: '결제 내역'),
          ],
        ),
      ),
      // TabBarView
      body: TabBarView(
        controller: _tabController,
        children: [
          Scaffold(
            backgroundColor: style.LIGHT_GREY,
            body: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Column(
                children: [
                  Text(
                    "수강료와 교재비는 함께 결제가 불가능합니다.",
                    style: TextStyle(color: style.DEEP_GREY, fontSize: 12),
                  ),
                ],
              ),
            ),
            // 하단바
            bottomNavigationBar: const BottomAppBar(
              elevation: 0,
              color: Colors.white,
              child: PaymentAnimatedButton(),
            ),
          ),
          const Center(
            child: Text("결제 내역"),
          )
        ],
      ),
    );
  }
}