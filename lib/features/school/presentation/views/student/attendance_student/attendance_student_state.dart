part of 'attendance_student_cubit.dart';

abstract class AttendanceStudentState extends Equatable {
  const AttendanceStudentState();

  @override
  List<Object> get props => [];
}

class AttendanceStudentInitial extends AttendanceStudentState {}
class AttendanceStudentLoading extends AttendanceStudentState {}
class AttendanceStudentLoaded extends AttendanceStudentState {
  final List<AttendanceModel> attendances;

  const AttendanceStudentLoaded(this.attendances);

  @override
  List<Object> get props => [attendances];
}
class AttendanceStudentError extends AttendanceStudentState {
  final String message;

  const AttendanceStudentError(this.message);

  @override
  List<Object> get props => [message];
}


