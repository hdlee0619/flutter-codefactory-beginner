import 'package:flutter/material.dart';

void main() {
  // 플러터 앱 실행
  runApp(
    // MaterialApp은 항상 최상위
    // Scaffold는 바로 아래에 위치
    // MaterialApp, Scaffold, Center, Text는 모두 위젯 => 화면에 보여지는 모든 요소는 위젯(Widget)
    MaterialApp(
      // 디버깅 배너 제거
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text('Hello World!', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}
