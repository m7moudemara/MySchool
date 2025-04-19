// import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Send real reset code when backend is ready
// class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
//   final SendResetCodeUseCase sendResetCodeUseCase;

//   ForgetPasswordCubit(this.sendResetCodeUseCase)
//       : super(ForgetPasswordInitial());

//   Future<void> sendCodeToEmail(String email) async {
//     try {
//       emit(ForgetPasswordLoading());
//       await sendResetCodeUseCase(email);
//       emit(ForgetPasswordSuccess());
//     } catch (e) {
//       emit(ForgetPasswordError(e.toString()));
//     }
//   }
// }
