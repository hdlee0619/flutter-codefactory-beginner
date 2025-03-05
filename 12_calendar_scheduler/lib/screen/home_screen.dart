import 'package:calendar_scheduler/components/schedule_card.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/components/calender.dart';
import '/components/schedule_bottom_sheet.dart';
import '/components/today_banner.dart';
import '/const/color.dart';
import '/database/drift.dart';

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
            builder: (_) {
              return ScheduleBottomSheet(selectedDay: selectedDay);
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
                child: StreamBuilder<List<ScheduleWithCategory>>(
                  stream: GetIt.I<AppDatabase>().streamSchedule(selectedDay),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final schedules = snapshot.data!;

                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8.0);
                      },
                      itemCount: schedules.length,
                      itemBuilder: (BuildContext context, int index) {
                        final scheduleWithCategory = schedules[index];
                        final schedule = scheduleWithCategory.schedule;
                        final category = scheduleWithCategory.category;

                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            GetIt.I<AppDatabase>().deleteSchedule(schedule.id);
                          },
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return ScheduleBottomSheet(
                                    id: schedule.id,
                                    selectedDay: selectedDay,
                                  );
                                },
                              );
                            },
                            child: ScheduleCard(
                              startTime: schedule.startTime,
                              endTime: schedule.endTime,
                              content: schedule.content,
                              color: Color(
                                int.parse('FF${category.color}', radix: 16),
                              ),
                            ),
                          ),
                        );
                      },
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
    return date.isAtSameMomentAs(selectedDay);
  }
}
