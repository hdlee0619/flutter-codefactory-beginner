import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://hdlee.dev');

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // ..는 loadRequest(homeUrl)을 호출하고 WebViewController를 반환한다.
  // final controller = WebViewController();
  // controller.loadRequest(homeUrl); 와 동일하다.
  WebViewController controller =
      WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(homeUrl);

  onPressed() {
    controller.loadRequest(homeUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: Color(0xFFA6E2E9),
        actions: [IconButton(onPressed: onPressed, icon: Icon(Icons.home))],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
