import 'package:flutter/material.dart';

import '/components/calender.dart';
import '/components/schedule_bottom_sheet.dart';
import '/components/schedule_card.dart';
import '/components/today_banner.dart';
import '/const/color.dart';
import '/model/schedule.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<Schedule>> schedules = {
    DateTime.utc(2025, 3, 31): [
      Schedule(
        id: 1,
        startTime: 9,
        endTime: 18,
        content: '예비군',
        color: categoryColors[0],
        date: DateTime.utc(2025, 03, 31),
        createdAt: DateTime.utc(2025, 3, 05),
      ),
      Schedule(
        id: 2,
        startTime: 19,
        endTime: 20,
        content: '예비군',
        color: categoryColors[0],
        date: DateTime.utc(2025, 03, 31),
        createdAt: DateTime.utc(2025, 3, 05),
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newSchedule = await showModalBottomSheet<Schedule>(
            context: context,
            backgroundColor: Colors.white,
            builder: (_) {
              return ScheduleBottomSheet(selectedDay: selectedDay);
            },
          );

          if (newSchedule == null) {
            return;
          }

          final dateExists = schedules.containsKey(newSchedule.date);

          final List<Schedule> existingSchedules =
              dateExists ? schedules[newSchedule.date]! : [];

          existingSchedules.add(newSchedule);

          setState(() {
            schedules = {...schedules, newSchedule.date: existingSchedules};
            ;
          });
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calender(
              focusedDay: DateTime(2025, 3, 5),
              onDaySelected: handleDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount:
                  schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 8.0);
                  },
                  itemCount:
                      schedules.containsKey(selectedDay)
                          ? schedules[selectedDay]!.length
                          : 0,
                  itemBuilder: (BuildContext context, int index) {
                    // List<Schedule>
                    final selectedSchedules = schedules[selectedDay]!;
                    final scheduleModel = selectedSchedules[index];

                    return ScheduleCard(
                      startTime: scheduleModel.startTime,
                      endTime: scheduleModel.endTime,
                      content: scheduleModel.content,
                      color: Color(
                        int.parse('FF${scheduleModel.color}', radix: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }

    return date.isAtSameMomentAs(selectedDay!);
  }
}
