import 'package:flutter/material.dart';

import '/components/number_to_image.dart';
import '/const/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_Number(maxNumber: maxNumber), _Slider(), _SaveButton()],
        ),
      ),
    );
  }
}

class _Number extends StatelessWidget {
  final double maxNumber;

  const _Number({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: NumberToImage(number: maxNumber.toInt()));
  }
}

class _Slider extends StatelessWidget {
  const _Slider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      child: Text('저장'),
    );
  }
}
