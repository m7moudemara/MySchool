import 'package:MySchool/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> execute(String userId, String newPassword) async {
    return await repository.changePassword(userId, newPassword);
  }
}