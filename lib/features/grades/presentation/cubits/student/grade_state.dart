import 'package:MySchool/features/grades/domain/entities/student_result_entity.dart';

abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final StudentResultEntity? result;

  ResultLoaded(this.result);
}

class ResultError extends ResultState {
  final String message;

  ResultError(this.message);
}
