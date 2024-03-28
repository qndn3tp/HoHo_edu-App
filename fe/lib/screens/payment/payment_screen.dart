import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_bar.dart';

////////////////////////
//   학원비 납부 화면  //
////////////////////////

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("학원비 납부"),
      body: const Center(),
    );
  }
}