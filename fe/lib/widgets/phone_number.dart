import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////////////
// 전화번호 위젯: 탭하면 전화걸기 //
///////////////////////////////////

class PhoneNumber extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumber({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        try {
          await launchUrl(Uri(scheme: 'tel',path: phoneNumber));
        } catch (e) {
          null;
        }
      },
      child: Text(phoneNumber, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 13),),
    );
  }
}