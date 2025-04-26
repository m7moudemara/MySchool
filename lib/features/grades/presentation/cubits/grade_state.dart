part of 'grade_cubit.dart';


abstract class GradesState {}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesLoaded extends GradesState {
  final List<Subject> grades;

  GradesLoaded(this.grades);
}

class GradesError extends GradesState {
  final String message;

  GradesError(this.message);
}
