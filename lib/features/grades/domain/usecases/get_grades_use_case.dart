import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:MySchool/features/grades/data/repositories/grades_repository.dart';

class GetGradesUseCase {
  final IGradesRepository repository;

  GetGradesUseCase(this.repository);

  Future<Subject> call(String studentId) {
    return repository.getGrades(studentId);
  }
}
