import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';
import 'package:MySchool/features/time_table/domain/repositories/timetable_repository.dart';

class GetTimetableForDayUseCase {
  final TimeTableRepository repository;

  GetTimetableForDayUseCase(this.repository);

  List<LessonEntity> call(String day) {
    return repository.getLessonsForDay(day);
  }
}