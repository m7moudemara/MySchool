import 'package:MySchool/features/grades/data/models/student_result_model.dart';

abstract class GradesLocalDatasource {
  Future<StudentResultModel?> getGrades(String term);
}