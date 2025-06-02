part of 'attendence_cubit.dart';

abstract class AttendenceState extends Equatable {
  const AttendenceState();

  @override
  List<Object> get props => [];
}

class AttendenceInitial extends AttendenceState {}
class AttendencePresentNumberChanged extends AttendenceState {
  final int presentNumber;
  final int absentNumber;

  const AttendencePresentNumberChanged(this.presentNumber, this.absentNumber);

  @override
  List<Object> get props => [presentNumber];
}
class AttendenceLoading extends AttendenceState {}

class AttendenceError extends AttendenceState {
  final String message;

  const AttendenceError(this.message);

  @override
  List<Object> get props => [message];
}



