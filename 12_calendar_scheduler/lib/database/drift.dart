import 'dart:io';

import 'package:calendar_scheduler/model/category.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '/model/schedule.dart';

part 'drift.g.dart';

@DriftDatabase(tables: [ScheduleTable, CategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<List<ScheduleTableData>> getSchedules(DateTime date) =>
      (select(scheduleTable)..where((table) => table.date.equals(date))).get();

  Future<ScheduleWithCategory> getSchedulesById(int id) {
    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.id.equals(id));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).getSingle();
  }

  Stream<List<ScheduleWithCategory>> streamSchedule(DateTime date) {
    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.date.equals(date));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).watch();
  }

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> updateSchedule(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)
        ..where((table) => table.id.equals(id))).write(data);

  Future<int> deleteSchedule(int id) =>
      (delete(scheduleTable)..where((table) => table.id.equals(id))).go();

  Future<List<CategoryTableData>> getCategories() =>
      select(categoryTable).get();

  Future<int> createCategory(CategoryTableCompanion data) =>
      into(categoryTable).insert(data);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = await getTemporaryDirectory();

    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
