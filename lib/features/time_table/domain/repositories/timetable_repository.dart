import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

abstract class TimeTableRepository {
  List<LessonEntity> getLessonsForDay(String day);
}