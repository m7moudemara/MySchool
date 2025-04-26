import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

abstract class TimeTableLocalDataSource {
  List<LessonEntity> getLessonsForDay(String day);
}