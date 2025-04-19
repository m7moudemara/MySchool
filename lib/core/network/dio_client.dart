import 'package:dio/dio.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        // TODO: Replace this mock URL with real one when backend is ready
        baseUrl: 'https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return dio;
  }
}
