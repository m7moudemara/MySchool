import 'package:MySchool/features/time_table/domain/entities/lesson.dart';

abstract class TimeTableRepository {
  List<Lesson> getLessonsForDay(String day);
}