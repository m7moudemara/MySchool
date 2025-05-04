import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';
import 'package:MySchool/features/time_table/domain/usecases/get_timetable_for_day.dart';

part 'timetable_state.dart';
class TimeTableCubit extends Cubit<TimeTableState> {
  final GetTimetableForDayUseCase getTimetableForDayUseCase;

  TimeTableCubit(this.getTimetableForDayUseCase) : super(TimeTableInitial());

  void loadTimetable(String day) {
    emit(TimeTableLoading());
    try {
      final lessons = getTimetableForDayUseCase(day);
      emit(TimeTableLoaded(lessons));
    } catch (e) {
      emit(TimeTableError("Failed to load timetable"));
    }
  }
}