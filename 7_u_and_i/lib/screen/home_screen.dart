import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          // 현재 실행하고 있는 디바이스의 가로 길이
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text('U&I'),
                      Text("우리 처음 만난 날"),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                      Text('D + 1'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Image.asset('assets/images/middle_image.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
