part of 'teacher_view_homework_cubit.dart';

abstract class TeacherViewHomeworkState extends Equatable {
  const TeacherViewHomeworkState();

  @override
  List<Object> get props => [];
}

class TeacherViewHomeworkInitial extends TeacherViewHomeworkState {}
class HomeWorksLoading extends TeacherViewHomeworkState {}

class HomeWorksLoaded extends TeacherViewHomeworkState {
  final List<HomeworkModel> homeWorks;

  const HomeWorksLoaded({required this.homeWorks});
}

class HomeWorksError extends TeacherViewHomeworkState {
  final String message;

  const HomeWorksError({required this.message});
}


