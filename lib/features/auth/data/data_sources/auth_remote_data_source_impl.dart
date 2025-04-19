


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
  
// TODO: Handle response (optional)
//   Future<void> sendResetCode(String email) async {
//   final response = await dio.post(
//     "$baseUrl/auth/send-reset-code",
//     data: {"email": email},
//   );
// }

// TODO: Implement the use case for verifying the code sent to the user's email.
// Future<void> resetPassword(String email, String newPassword) async {
//   await dio.post(
//     "$baseUrl/auth/reset-password",
//     data: {"email": email, "password": newPassword},
//   );
// }


}
