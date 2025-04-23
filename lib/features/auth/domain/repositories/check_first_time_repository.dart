import 'package:MySchool/features/auth/domain/repositories/auth_repository.dart';

class CheckFirstLoginUseCase {
  final AuthRepository repository;

  CheckFirstLoginUseCase(this.repository);

  Future<bool> call(String userId) async {
    return await repository.isFirstLogin(userId);
  }
}