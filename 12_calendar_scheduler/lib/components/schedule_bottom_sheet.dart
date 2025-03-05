import 'package:flutter/material.dart';

import '/const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            children: [
              _Time(),
              SizedBox(height: 8.0),
              _Content(),
              SizedBox(height: 8.0),
              _Category(
                selectedColor: selectedColor,
                onTap: handleSelectedColor,
              ),
              SizedBox(height: 8.0),
              _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  handleSelectedColor(String color) {
    setState(() {
      selectedColor = color;
    });
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: '시작 시간')),
        SizedBox(width: 16.0),
        Expanded(child: CustomTextField(label: '마감 시간')),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomTextField(label: '내용', expanded: true));
  }
}

typedef OnColorSelected = void Function(String color);

class _Category extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onTap;

  const _Category({
    required this.selectedColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          categoryColors
              .map(
                (color) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      onTap(color);
                    },
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: Color(int.parse('FF$color', radix: 16)),
                        shape: BoxShape.circle,
                        border:
                            color == selectedColor
                                ? Border.all(color: Colors.black, width: 4.0)
                                : null,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
