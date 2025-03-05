import 'package:flutter/material.dart';

import '/const/color.dart';
import '/model/schedule.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;

  const ScheduleBottomSheet({required this.selectedDay, super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  String selectedColor = categoryColors.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartTimeSaved: handleStartTimeSaved,
                  onStartTimeValidator: handleStartTimeValidator,
                  onEndTimeSaved: handleEndTimeSaved,
                  onEndTimeValidator: handleEndTimeValidator,
                ),
                SizedBox(height: 8.0),
                _Content(
                  onSaved: handleContentSaved,
                  onValidate: handleContentValidator,
                ),
                SizedBox(height: 8.0),
                _Category(
                  selectedColor: selectedColor,
                  onTap: handleSelectedColor,
                ),
                SizedBox(height: 8.0),
                _SaveButton(onPressed: handleSaveSchedule),
              ],
            ),
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

  void handleStartTimeSaved(String? value) {
    if (value == null) {
      return;
    }

    startTime = int.parse(value);
  }

  String? handleStartTimeValidator(String? value) {
    if (value == null) {
      return '값을 입력해주세요!';
    }

    if (int.tryParse(value) == null) {
      return '숫자만 입력해주세요!';
    }

    final time = int.parse(value);

    if (time > 24 || time < 0) {
      return '0 ~ 24 사이의 값을 입력해주세요!';
    }

    return null;
  }

  void handleEndTimeSaved(String? value) {
    if (value == null) {
      return;
    }

    endTime = int.parse(value);
  }

  String? handleEndTimeValidator(String? value) {
    if (value == null) {
      return '값을 입력해주세요!';
    }

    if (int.tryParse(value) == null) {
      return '숫자만 입력해주세요!';
    }

    final time = int.parse(value);

    if (time > 24 || time < 0) {
      return '0 ~ 24 사이의 값을 입력해주세요!';
    }

    return null;
  }

  void handleContentSaved(String? value) {
    if (value == null) {
      return;
    }

    content = value;
  }

  String? handleContentValidator(String? value) {
    if (value == null) {
      return '내용을 입력해주세요!';
    }

    if (value.length < 5) {
      return '5자 이상을 입력해주세요!';
    }

    return null;
  }

  void handleSaveSchedule() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();

    final newSchedule = Schedule(
      id: 999,
      startTime: startTime!,
      endTime: endTime!,
      content: content!,
      color: selectedColor,
      date: widget.selectedDay,
      createdAt: DateTime.now().toUtc(),
    );

    Navigator.of(context).pop(newSchedule);
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartTimeSaved;
  final FormFieldSetter<String> onEndTimeSaved;
  final FormFieldValidator<String> onStartTimeValidator;
  final FormFieldValidator<String> onEndTimeValidator;

  const _Time({
    required this.onStartTimeSaved,
    required this.onEndTimeSaved,
    required this.onStartTimeValidator,
    required this.onEndTimeValidator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            onSaved: onStartTimeSaved,
            validator: onStartTimeValidator,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            onSaved: onEndTimeSaved,
            validator: onEndTimeValidator,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({required this.onSaved, required this.onValidate, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expanded: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
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
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
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
