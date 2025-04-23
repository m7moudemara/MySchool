import 'package:MySchool/features/time_table/domain/entities/lesson.dart';
import 'package:MySchool/features/time_table/domain/repositories/timetable_repository.dart';

class GetTimetableForDayUseCase {
  final TimeTableRepository repository;

  GetTimetableForDayUseCase(this.repository);

  List<Lesson> call(String day) {
    return repository.getLessonsForDay(day);
  }
}