import 'package:MySchool/features/grades/domain/entities/student_result_entity.dart';

abstract class GradesRepository {
  Future<StudentResultEntity?> getGrades(String term, int studentId);
}
