import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

// StatelessWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC90481),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24,
        children: [
          Center(child: Image.asset('assets/images/test_logo.png')),
          Text('Splash Screen Project', style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    );
  }
}
