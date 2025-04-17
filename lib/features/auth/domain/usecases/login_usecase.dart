import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Map<String, dynamic>> call({
    required String idNumber,
    required String password,
  }) {
    return repository.login(idNumber: idNumber, password: password);
  }
}
