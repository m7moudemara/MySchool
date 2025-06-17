import 'package:MySchool/main.dart';
import 'package:dio/dio.dart';
import 'auth_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:MySchool/core/constants/strings.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/auth/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "user_name": idNumber.trim(),
          "password": password.trim(),
        }),
      );
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body)['user'];
        if (user == null || user.isEmpty) {
          return {
            'success': false,
            'message': 'No user found with this ID number',
          };
        }
        sharedPrefController.saveToken(jsonDecode(response.body)['token']);
        Map<String, dynamic> userData =
            user['role'] == 'Admin'
                ? await getAdminDashboardData(
                  user['id'].toString(),
                  jsonDecode(response.body)['token'],
                )
                : await getDashboardData(
                  user['id'].toString(),
                  jsonDecode(response.body)['token'],
                  user['role'],
                );
        if (user['role'] == 'Student') {
          sharedPrefController.saveClassName(userData['class_name']);
        }
        return {
          'success': true,
          'user': user,
          'dashboard': userData,
          'role': user['role'],
          'token': jsonDecode(response.body)['token'],
        };
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error occurred'};
    }
  }

  Future<Map<String, dynamic>> getDashboardData(
    String userId,
    String token,
    String role,
  ) async {
    try {
      final url = Uri.parse(
        '$baseUrl/api/dashboard/${role.toLowerCase()}/$userId',
      );
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // Unable to show SnackBar here due to missing BuildContext.
        throw Exception('Failed to fetch dashboard data');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> getAdminDashboardData(
    String userId,
    String token,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/api/dashboard/admin');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // Unable to show SnackBar here due to missing BuildContext.
        throw Exception('Failed to fetch dashboard data');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<bool> isFirstLogin(String userId) async {
    try {
      final response = await dio.get('/users/$userId');
      final data = response.data;

      if (data['is_first_login'] is bool) {
        return data['is_first_login'];
      } else if (data['is_first_login'] is String) {
        return data['is_first_login'].toLowerCase() == 'true';
      } else if (data['is_first_login'] is int) {
        return data['is_first_login'] == 1;
      }
      return true;
    }  catch (e) {
      return true;
    }
  }

  @override
  Future<void> changePassword(String userId, String newPassword) async {
    try {
      await dio.put(
        '/users/$userId',
        data: {'password': newPassword, 'is_first_login': false},
      );
    } on DioException catch (e) {
      throw Exception('Failed to change password: ${e.message}');
    }
  }
}
