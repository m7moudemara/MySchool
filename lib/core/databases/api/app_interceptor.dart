import 'dart:developer';

import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("🔵 Request:");
    log("➡️ URL: ${options.uri}");
    log("➡️ Method: ${options.method}");
    log("➡️ Headers: ${options.headers}");
    log("➡️ Body: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("🟢 Response:");
    log("✅ URL: ${response.requestOptions.uri}");
    log("✅ Status Code: ${response.statusCode}");
    log("✅ Data: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("🔴 Error:");
    log("❌ URL: ${err.requestOptions.uri}");
    log("❌ Message: ${err.message}");
    log("❌ Response: ${err.response?.data}");
    super.onError(err, handler);
  }
}
