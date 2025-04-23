import 'package:MySchool/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final Dio dio = Dio();

  AuthRepositoryImpl(this.remote);

  @override
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  }) {
    return remote.login(idNumber: idNumber, password: password);
  }

@override
Future<bool> isFirstLogin(String userId) async {
  return await remote.isFirstLogin(userId);
}


@override
Future<void> changePassword(String userId, String newPassword) async {
  return await remote.changePassword(userId, newPassword);
}



}


