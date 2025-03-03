import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> images = [
    'assets/images/image0.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: images.map((image) => Image.asset(image)).toList(),
      ),
    );
  }
}
