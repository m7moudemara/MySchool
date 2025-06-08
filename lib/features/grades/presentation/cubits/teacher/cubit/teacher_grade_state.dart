import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';

abstract class TeacherGradeState {}

class TeacherGradeInitial extends TeacherGradeState {}

class TeacherGradeLoading extends TeacherGradeState {}

class TeacherGradeLoaded extends TeacherGradeState {
  final List<StudentResult?> studentResults;

  TeacherGradeLoaded({required this.studentResults});
}

class TeacherGradeError extends TeacherGradeState {
  final String message;

  TeacherGradeError({required this.message});
}
