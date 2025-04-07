import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    _dio.options.baseUrl = 'https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool';
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String idNumber,
    required String password,
  }) async {
    try {
      // 1. التحقق من عدم وجود مستخدم بنفس البريد الإلكتروني
      final emailResponse = await _dio.get(
        '/users',
        queryParameters: {'email': email},
      );

      if (emailResponse.data.isNotEmpty) {
        return {'success': false, 'error': 'Email already exists'};
      }

      // 2. التحقق من عدم وجود مستخدم بنفس رقم الهوية
      final idResponse = await _dio.get(
        '/users',
        queryParameters: {'idNumber': idNumber},
      );

      if (idResponse.data.isNotEmpty) {
        return {'success': false, 'error': 'ID number already exists'};
      }

      // 3. إنشاء المستخدم الجديد
      final response = await _dio.post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'idNumber': idNumber,
          'password': password,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      return {'success': true, 'user': response.data};
    } catch (e) {
      return {'success': false, 'error': 'Registration failed. Please try again.'};
    }
  }

  // دالة لتسجيل الدخول
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  }) async {
    try {
      // التحقق من وجود المستخدم
      final response = await _dio.get(
        '/users',
        queryParameters: {'idNumber': idNumber, 'password': password},
      );

      if (response.data.isEmpty) {
        return {'success': false, 'error': 'Invalid credentials'};
      }

      return {'success': true, 'user': response.data[0]};
    } catch (e) {
      return {'success': false, 'error': 'Login failed. Please try again.'};
    }
  }
}
