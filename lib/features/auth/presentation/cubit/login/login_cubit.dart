import 'package:MySchool/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({
    required String idNumber,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await loginUseCase(idNumber: idNumber, password: password);

    if (result['success']) {
      emit(LoginSuccess(userJson: result['user']));
    } else {
      emit(LoginFailure(error: '${result['message']}'));

    }
  }
}
