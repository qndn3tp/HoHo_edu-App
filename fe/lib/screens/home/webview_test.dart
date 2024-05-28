import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewTest extends StatefulWidget {
  const WebviewTest({super.key});

  @override
  State<WebviewTest> createState() => _WebviewTestState();
}

class _WebviewTestState extends State<WebviewTest> {
  WebViewController? _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://hohoschool.com/app/index.html'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        ScaffoldMessenger.of(context).clearSnackBars();
        if (_webViewController != null) {
          if (await _webViewController!.canGoBack()) {
            _webViewController!.goBack();
            return Future.value(false);
          }
        }
        Get.off(const HomeScreen());     // 최상단 webView에서 뒤로가기 클릭 시 돌아갈 위치
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: _webViewController!,
        ),
      ),
    );
  }
}