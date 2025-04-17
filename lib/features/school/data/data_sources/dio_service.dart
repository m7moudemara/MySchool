import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final response = await _dio.get("https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users");

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }
}
