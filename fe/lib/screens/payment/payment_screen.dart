import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/screens/payment/payment_history_screen.dart';
import 'package:flutter_application/screens/payment/payment_list_screen.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

////////////////////////
//   학원비 납부 화면  //
////////////////////////

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
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
        children: const [
          // 학원비 결제 화면
          PaymentListScreen(),
          // 결제내역 화면
          PaymentHistoryScreen(),
        ],
      ),
    );
  }
}