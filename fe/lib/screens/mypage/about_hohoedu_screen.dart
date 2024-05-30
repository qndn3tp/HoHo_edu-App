import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import 'package:flutter_application/widgets/shortcut_icon.dart';
import 'package:url_launcher/url_launcher.dart';

/////////////////////////
// 호호에듀 더보기 화면 //
/////////////////////////
class AboutHohoeduScreen extends StatelessWidget {
  AboutHohoeduScreen({super.key});

  final shortcutList = [
  {
    "title": "홈페이지",
    "imgPath": "assets/images/shortcut_logo/hoho.png",
    "url":"https://hohoedu.co.kr",
  },
  {
    "title": "블로그",
    "imgPath": "assets/images/shortcut_logo/naver.png",
    "url": "https://blog.naver.com/st8898ds",
  },
  {
    "title": "유튜브",
    "imgPath": "assets/images/shortcut_logo/youtube.png",
    "url": "https://youtube.com/@tv-ex4in?si=iiHywF2iEXabR0Sk",
  },
  {
    "title": "카톡채널",
    "imgPath": "assets/images/shortcut_logo/kakao.png",
    "url": "https://pf.kakao.com/_xeexhxkK",
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: customAppBar("호호에듀 더보기"),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: shortcutList.length,
        itemBuilder: (c, i) {
          return GestureDetector(
            onTap: (){
              launchUrl(Uri.parse(shortcutList[i]['url'].toString()));
            },
            child: shortcutIcon(shortcutList[i]['title'], shortcutList[i]['url'], shortcutList[i]['imgPath'])
          );
        },
      ),
    );
  }
}
