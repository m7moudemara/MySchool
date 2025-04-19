import 'package:MySchool/features/auth/domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  }) {
    return remote.login(idNumber: idNumber, password: password);
  }

// TODO: Replace mock code with real API call
//   @override
// Future<void> sendResetCode(String email) {
//   return remoteDataSource.sendResetCode(email);
// }

}


