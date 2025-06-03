part of 'classes_cubit.dart';

abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

class ClassesInitial extends ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesLoaded extends ClassesState {
  final List<ClassStudentModel> classes;

  const ClassesLoaded(this.classes);
}

class ClassesLoadedError extends ClassesState {
  final String message;

  const ClassesLoadedError({required this.message});
}
