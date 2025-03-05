import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 40.0);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text('서울', style: textStyle),
            Text('2025-03-06', style: textStyle.copyWith(fontSize: 20.0)),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/best.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(height: 20.0),
            Text('보통', style: textStyle.copyWith(fontWeight: FontWeight.w700)),
            Text(
              '나쁘지 않네요!',
              style: textStyle.copyWith(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
