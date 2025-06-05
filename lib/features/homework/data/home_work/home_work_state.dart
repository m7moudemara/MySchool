part of 'home_work_cubit.dart';

abstract class HomeWorkState extends Equatable {
  const HomeWorkState();

  @override
  List<Object> get props => [];
}

class HomeWorkInitial extends HomeWorkState {}

class HomeWorkLoading extends HomeWorkState {}

class HomeWorkLoaded extends HomeWorkState {
  final List<HomeworkModel> homeWorks;

  const HomeWorkLoaded(this.homeWorks);

  @override
  List<Object> get props => [homeWorks];
}

class HomeWorkError extends HomeWorkState {
  final String message;

  const HomeWorkError(this.message);

  @override
  List<Object> get props => [message];
}
class HomeWorkSubmittedLoading extends HomeWorkState {
}

class HomeWorkSubmittedSuccess extends HomeWorkState {


}

class HomeWorkSubmittedError extends HomeWorkState {
  final String message;

  const HomeWorkSubmittedError(this.message);


}


