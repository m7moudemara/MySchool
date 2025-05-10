import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:dio/dio.dart';



class ResultsApi {
  final Dio _dio;

  ResultsApi(this._dio); 

  Future<List<Subject>> fetchResults() async {
    try {
      final response = await _dio.get('https://6800fd7981c7e9fbcc411c4e.mockapi.io/result');
      List data = response.data;
      return data.map((item) => Subject.fromJson(item)).toList();
    } catch (e) {
      throw Exception("Failed to load results: $e");
    }
  }
}
abstract class IGradesRemoteDataSource {
  Future<Subject> getGrades(String studentId);
}

class GradesRemoteDataSource implements IGradesRemoteDataSource {
  final Dio dio;

  GradesRemoteDataSource(this.dio);

  @override
  Future<Subject> getGrades(String studentId) async {
    final response = await dio.get('https://6800fd7981c7e9fbcc411c4e.mockapi.io/result/$studentId'); 
    return Subject.fromJson(response.data);
  }
}
