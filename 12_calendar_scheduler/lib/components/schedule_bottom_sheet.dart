import 'package:calendar_scheduler/database/drift.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;

  const ScheduleBottomSheet({required this.selectedDay, this.id, super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  void initState() {
    super.initState();

    initCategory();
  }

  initCategory() async {
    if (widget.id != null) {
      final response = await GetIt.I<AppDatabase>().getSchedulesById(
        widget.id!,
      );

      setState(() {
        selectedColorId = response.category.id;
      });
    } else {
      final response = await GetIt.I<AppDatabase>().getCategories();

      setState(() {
        selectedColorId = response.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedColorId == null) {
      return Container();
    }

    return FutureBuilder(
      future:
          widget.id == null
              ? null
              : GetIt.I<AppDatabase>().getSchedulesById(widget.id!),
      builder: (context, snapshot) {
        if (widget.id != null &&
            snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data?.schedule;

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
                      endTimeInitValue: data?.endTime.toString(),
                      startTimeInitValue: data?.startTime.toString(),
                    ),
                    SizedBox(height: 8.0),
                    _Content(
                      onSaved: handleContentSaved,
                      onValidate: handleContentValidator,
                      contentInitValue: data?.content,
                    ),
                    SizedBox(height: 8.0),
                    _Category(
                      selectedColorId: selectedColorId!,
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
      },
    );
  }

  handleSelectedColor(int colorId) {
    setState(() {
      selectedColorId = colorId;
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

  void handleSaveSchedule() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();

      final database = GetIt.I<AppDatabase>();

      if (widget.id == null) {
        await database.createSchedule(
          ScheduleTableCompanion(
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
            date: Value(widget.selectedDay),
          ),
        );
      } else {
        await database.updateSchedule(
          widget.id!,
          ScheduleTableCompanion(
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
            date: Value(widget.selectedDay),
          ),
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartTimeSaved;
  final FormFieldSetter<String> onEndTimeSaved;
  final FormFieldValidator<String> onStartTimeValidator;
  final FormFieldValidator<String> onEndTimeValidator;

  final String? startTimeInitValue;
  final String? endTimeInitValue;

  const _Time({
    required this.onStartTimeSaved,
    required this.onEndTimeSaved,
    required this.onStartTimeValidator,
    required this.onEndTimeValidator,
    this.startTimeInitValue,
    this.endTimeInitValue,
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
            initValue: startTimeInitValue,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            onSaved: onEndTimeSaved,
            validator: onEndTimeValidator,
            initValue: endTimeInitValue,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  final String? contentInitValue;

  const _Content({
    required this.onSaved,
    required this.onValidate,
    this.contentInitValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expanded: true,
        onSaved: onSaved,
        validator: onValidate,
        initValue: contentInitValue,
      ),
    );
  }
}

typedef OnColorSelected = void Function(int colorId);

class _Category extends StatelessWidget {
  final int selectedColorId;
  final OnColorSelected onTap;

  const _Category({
    required this.selectedColorId,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<AppDatabase>().getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Row(
          children:
              snapshot.data!
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          onTap(e.id);
                        },
                        child: Container(
                          width: 32.0,
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: Color(int.parse('FF${e.color}', radix: 16)),
                            shape: BoxShape.circle,
                            border:
                                e.id == selectedColorId
                                    ? Border.all(
                                      color: Colors.black,
                                      width: 4.0,
                                    )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        );
      },
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
