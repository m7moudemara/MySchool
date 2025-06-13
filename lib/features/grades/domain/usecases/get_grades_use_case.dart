import 'package:MySchool/features/grades/domain/entities/student_result_entity.dart';
import 'package:MySchool/features/grades/domain/repositories/grades_repository.dart';

class GetGradesUseCase {
  final GradesRepository repository;

  GetGradesUseCase(this.repository);

  Future<StudentResultEntity?> call(String term, int studentId) {
    return repository.getGrades(term, studentId);
  }
}
