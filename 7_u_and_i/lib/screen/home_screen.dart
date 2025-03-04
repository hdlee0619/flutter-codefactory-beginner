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
          child: Column(children: [_Top(), _Bottom()]),
        ),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text('U&I', style: textTheme.displayLarge),
            Text('우리 처음 만난 날', style: textTheme.bodyLarge),
            Text('2022-11-11', style: textTheme.bodyMedium),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
              iconSize: 60.0,
              color: Colors.red,
            ),
            Text('D + 1', style: textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(child: Image.asset('assets/images/middle_image.png')),
    );
  }
}
