import 'package:MySchool/features/auth/domain/repositories/auth_repository.dart';

import '../repositories/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository repository;
  ResetPasswordUseCase(this.repository);
  Future<void> execute(String newPassword) {
    return repository.resetPassword(newPassword: newPassword);
  }

// TODO: Replace mock implementation when backend is ready
// class SendResetCodeUseCase {
//   final AuthRepository repository;

//   SendResetCodeUseCase(this.repository);

//   Future<void> call(String email) async {
//     return repository.sendResetCode(email);
//   }
// }
}
