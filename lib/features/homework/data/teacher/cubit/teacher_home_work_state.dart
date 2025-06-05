part of 'teacher_home_work_cubit.dart';

abstract class TeacherHomeWorkState extends Equatable {
  const TeacherHomeWorkState();

  @override
  List<Object> get props => [];
}

class TeacherHomeWorkInitial extends TeacherHomeWorkState {}

class TeacherClassLoading extends TeacherHomeWorkState {}

class TeacherClassLoaded extends TeacherHomeWorkState {
  final List<TeacherClassModel> classes;
  final List<TeacherSubjectModel> subjects;

  const TeacherClassLoaded({required this.classes, required this.subjects});
}

class TeacherClassError extends TeacherHomeWorkState {
  final String message;

  const TeacherClassError({required this.message});
}

class HomeWorkUploaded extends TeacherHomeWorkState {
  final String message;

  const HomeWorkUploaded(this.message);
}

class HomeWorkUploadedError extends TeacherHomeWorkState {
  final String message;

  const HomeWorkUploadedError(this.message);
}

