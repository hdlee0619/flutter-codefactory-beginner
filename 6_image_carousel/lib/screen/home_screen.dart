import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage == images.length) {
        nextPage = 0;
      }

      controller.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  final List<String> images = [
    'assets/images/image0.png',
    'assets/images/image1.png',
    'assets/images/image2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: images.map((image) => Image.asset(image)).toList(),
      ),
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }

    controller.dispose();

    super.dispose();
  }
}
