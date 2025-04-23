

import '../repositories/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository repository;
  ResetPasswordUseCase(this.repository);
  Future<void> execute(String newPassword) {
    return repository.resetPassword(newPassword: newPassword);
  }

}
