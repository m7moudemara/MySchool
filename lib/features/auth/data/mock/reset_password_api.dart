import 'package:dio/dio.dart';

class ResetPasswordApi {
  final Dio _dio = Dio();
  final String baseUrl = 'https://67f2952eec56ec1a36d38b8b.mockapi.io/api/v1/users';

  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final response = await _dio.get(baseUrl);
      final users = response.data as List;

      final user = users.firstWhere((u) => u['email'] == email, orElse: () => null);

      if (user == null) return false;

      final userId = user['id'];

      await _dio.patch('$baseUrl/$userId', data: {
        'password': newPassword,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
