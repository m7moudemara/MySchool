import 'package:MySchool/features/time_table/data/datasources/timetable_local_data_source.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson.dart';
import 'package:MySchool/features/time_table/domain/repositories/timetable_repository.dart';

class TimeTableRepositoryImpl implements TimeTableRepository {
  final TimeTableLocalDataSource localDataSource;

  TimeTableRepositoryImpl(this.localDataSource);

  @override
  List<Lesson> getLessonsForDay(String day) {
    return localDataSource.getLessonsForDay(day);
  }
}