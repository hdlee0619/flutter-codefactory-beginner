import 'package:flutter/material.dart';

import '/components/calender.dart';
import '/components/schedule_bottom_sheet.dart';
import '/components/schedule_card.dart';
import '/components/today_banner.dart';
import '/const/color.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            builder: (_) {
              return ScheduleBottomSheet();
            },
          );
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
            TodayBanner(selectedDay: selectedDay, taskCount: 0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: ListView(
                  children: [
                    ScheduleCard(
                      startTime: DateTime(2025, 3, 5, 12),
                      endTime: DateTime(2025, 3, 5, 13),
                      content: '점심 먹기',
                      color: Colors.blue,
                    ),
                  ],
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
