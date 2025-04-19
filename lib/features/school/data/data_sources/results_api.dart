import 'package:dio/dio.dart';
import '../models/result_model.dart';

class ResultsApi {
  final Dio _dio = Dio();

  Future<List<ResultModel>> fetchResults() async {
    try {
      final response = await _dio.get('https://6800fd7981c7e9fbcc411c4e.mockapi.io/result');
      List data = response.data;
      return data.map((item) => ResultModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Failed to load results: $e");
    }
  }
}
