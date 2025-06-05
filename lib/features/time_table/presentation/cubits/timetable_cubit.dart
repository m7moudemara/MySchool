import 'package:MySchool/features/time_table/data/datasources/lessons_repository.dart';
import 'package:MySchool/features/time_table/data/datasources/lessons_web_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';
import 'package:MySchool/features/time_table/domain/usecases/get_timetable_for_day.dart';

part 'timetable_state.dart';

class TimeTableCubit extends Cubit<TimeTableState> {
  final GetTimetableForDayUseCase getTimetableForDayUseCase;

  TimeTableCubit(this.getTimetableForDayUseCase) : super(TimeTableInitial());

  void loadTimetable(String day) async {
    emit(TimeTableLoading());
    try {
      LessonsRepository lessonsRepository = LessonsRepository(
        LessonsWebServices(),
      );
      Future.delayed(Duration(seconds: 2));
      List<LessonEntity> lessons = await lessonsRepository.getLessons();
      final xx = dayName.indexWhere((element) => day == element);
      List<LessonEntity> selectedLessons =
          lessons.where((element) => element.day == xx).toList();
      emit(TimeTableLoaded(selectedLessons));
    } catch (e) {
      emit(TimeTableError("Failed to load timetable"));
    }
  }
}


List<String> dayName = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];
