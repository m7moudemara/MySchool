import 'package:MySchool/features/auth/domain/repositories/check_first_time_repository.dart';
import 'package:MySchool/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final CheckFirstLoginUseCase checkFirstLoginUseCase;

  LoginCubit({required this.loginUseCase, required this.checkFirstLoginUseCase})
    : super(LoginInitial());

  Future<void> login({
    required String idNumber,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await loginUseCase(idNumber: idNumber, password: password);

    if (result['success'] == true) {
      final isMustChangePassword = result['user']['must_change_password'];

      if (isMustChangePassword) {
        emit(FirstLoginRequired(userJson: result['user']));
      } else {
        emit(
          LoginSuccess(
            userJson: result['user'],
            dashboardJson: result['dashboard'],
          ),
        );
      }
    } else {
      emit(LoginFailure(error: result['message']));
    }
  }
}
