import 'package:flutter/material.dart';
import 'package:flutter_application/screens/Notice/Notice_list_tile.dart';
import 'package:flutter_application/screens/notice/tab_bar_scroller.dart';
import 'package:flutter_application/widgets/app_bar.dart';
import '../../style.dart' as style;

////////////////////////
//    알림장  화면    //
////////////////////////

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> with SingleTickerProviderStateMixin {
  
  // 화면 스크롤 컨트롤러
  final ScrollController scrollController = ScrollController();

  // TabBar 인덱스
  int current = 0;
  
  // TabBar Tabs
  final List<String> tabs = [
    "전체",
    "공지",  
    "수업",
    "출석",
    "결제",
    "독클",
  ];

  // TabBar TapView
  final List<Widget> pages = [
    totalNotice(),
    officialNotice(),
    classNotice(),
    attendanceNotice(),
    paymentNotice(),
    bookNotice(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // 상단바
      appBar: customAppBar("알림장"),
      // TabBar, TabView
      body: Column(
          children: [
            // TabBar
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        current = index;
                        // tab 클릭시 인덱스에 따른 TabBar 내 스크롤 이동
                        scrollToIndex(context, index, scrollController, tabs.length);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.all(10),
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: current == index 
                          ? style.DEEP_GREY
                          : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: current == index
                          ? Border.all(color: style.DEEP_GREY, width: 2)
                          : Border.all(color: const Color(0xffdfdfdf), width: 2),
                      ),
                      // Tabs 텍스트
                      child: Center(
                        child: Text(
                          tabs[index], 
                          style: TextStyle(
                            color: current == index
                            ? Colors.white
                            : style.DEEP_GREY,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                    ),
                  );
                })
                ),
            ),
            // Tab View
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                switchOutCurve: Curves.easeInOut, 
                switchInCurve: Curves.easeInOut, 
                child: KeyedSubtree(
                  key: ValueKey(current), 
                  child: pages[current]),
              ),
            ),
          ],
        ),
    );
  }
}


Widget totalNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 0);
        }),
  );
}
Widget officialNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 0);
      }),
  );
}
Widget classNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 1);
      }),
  );
}
Widget attendanceNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 2);
      }),
  );
}
Widget paymentNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 3);
      }),
  );
}
Widget bookNotice() {
  return Center(
    child: ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return noticeListTile(context, 4);
      }),
  );
}