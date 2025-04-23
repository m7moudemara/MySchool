part of 'timetable_cubit.dart'; // يجب أن تطابق اسم الملف الرئيسي

abstract class TimeTableState {}

class TimeTableInitial extends TimeTableState {}

class TimeTableLoading extends TimeTableState {}

class TimeTableLoaded extends TimeTableState {
  final List<Lesson> lessons;
  TimeTableLoaded(this.lessons);
}

class TimeTableError extends TimeTableState {
  final String message;
  TimeTableError(this.message);
}