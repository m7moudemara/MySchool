import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final Map<String, dynamic> userJson;
  const LoginSuccess({required this.userJson});

  @override
  List<Object?> get props => [userJson];
}

class FirstLoginRequired extends LoginState {  
  final Map<String, dynamic> userJson;
  const FirstLoginRequired({required this.userJson});
  @override
  List<Object?> get props => [userJson];
}
class LoginFailure extends LoginState {
  final String error;
  const LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
