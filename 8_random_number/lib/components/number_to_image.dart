import 'package:flutter/material.dart';

class NumberToImage extends StatelessWidget {
  final int number;

  const NumberToImage({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          number
              .toInt()
              .toString()
              .split('')
              .map(
                (number) => Image.asset(
                  'assets/images/$number.png',
                  width: 50.0,
                  height: 70.0,
                ),
              )
              .toList(),
    );
  }
}
