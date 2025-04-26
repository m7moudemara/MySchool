import 'package:MySchool/features/grades/data/data_sources/results_api.dart';
import 'package:MySchool/features/grades/data/models/subject_model.dart';

abstract class IGradesRepository {
  Future<Subject> getGrades(String studentId);
}

class GradesRepositoryImpl implements IGradesRepository {
  final IGradesRemoteDataSource dataSource;

  GradesRepositoryImpl(this.dataSource);

  @override
  Future<Subject> getGrades(String studentId) {
    return dataSource.getGrades(studentId);
  }
}
