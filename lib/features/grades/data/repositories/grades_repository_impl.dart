import 'package:MySchool/features/grades/data/data_sources/grades_local_datasource.dart';
import 'package:MySchool/features/grades/domain/entities/student_result_entity.dart';
import 'package:MySchool/features/grades/domain/repositories/grades_repository.dart';

class GradesRepositoryImpl implements GradesRepository {
  final GradesLocalDatasource localDataSource;

  GradesRepositoryImpl(this.localDataSource);

  @override
  Future<StudentResultEntity?> getGrades(String term) async {
    return await localDataSource.getGrades(term);
  }
}
