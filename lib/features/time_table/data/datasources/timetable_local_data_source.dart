import 'package:MySchool/features/time_table/domain/entities/lesson.dart';

abstract class TimeTableLocalDataSource {
  List<Lesson> getLessonsForDay(String day);
}