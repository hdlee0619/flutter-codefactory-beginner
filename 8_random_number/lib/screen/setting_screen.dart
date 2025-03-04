import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/components/number_to_image.dart';
import '/const/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({required this.maxNumber, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Number(maxNumber: maxNumber),
            _Slider(maxNumber: maxNumber, onChanged: handleSlider),
            _SaveButton(onPressed: navigateHome),
          ],
        ),
      ),
    );
  }

  handleSlider(double value) {
    setState(() {
      maxNumber = value;
    });
  }

  navigateHome() {
    Navigator.of(context).pop(maxNumber.toInt());
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
  final double maxNumber;
  final ValueChanged<double> onChanged;

  const _Slider({required this.maxNumber, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSlider(
      value: maxNumber,
      max: 100000,
      min: 1000,
      onChanged: onChanged,
      activeColor: blueColor,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      child: Text('저장'),
    );
  }
}
