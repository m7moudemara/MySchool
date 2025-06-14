import '../entities/timetable_entity.dart';

abstract class AddTimeTableRepository {
  Future<List<TimeTableEntity>> getAllTimeTables();
  Future<void> addTimeTable(TimeTableEntity timeTable);
  Future<void> updateTimeTable(TimeTableEntity timeTable);
  Future<void> deleteTimeTable(String id);
}
