


import 'package:dio/dio.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  }) async {
    try {
      final response = await dio.get(
        '/users',
        queryParameters: {
          'idNumber': idNumber,
          'password': password,
        },
      );

      if (response.data.isEmpty) {
        return {'success': false, 'error': 'Invalid credentials'};
      }

      final user = response.data[0];
      final role = user['role']; // optional: parseUserRole later

      return {'success': true, 'user': user, 'role': role};
    } catch (e) {
      return {'success': false, 'error': 'Login failed. Please try again.'};
    }
  }
}
