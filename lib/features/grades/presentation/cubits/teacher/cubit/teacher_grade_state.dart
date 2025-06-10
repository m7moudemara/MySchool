import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';

import '../../../../../homework/data/teacher/teacher_subject_model.dart';

abstract class TeacherGradeState {}

class TeacherGradeInitial extends TeacherGradeState {}

class TeacherGradeLoading extends TeacherGradeState {}

class TeacherGradeLoaded extends TeacherGradeState {
  final List<TeacherResultModel?> studentResults;
  final List<TeacherSubjectModel?> subjects;

  TeacherGradeLoaded({required this.studentResults,required this.subjects});
}

class TeacherGradeError extends TeacherGradeState {
  final String message;

  TeacherGradeError({required this.message});
}

class SubjectsLoading extends TeacherGradeState {
}

class SubjectsLoaded extends TeacherGradeState {
  final List<TeacherSubjectModel> subjects;

  SubjectsLoaded({required this.subjects});
}


