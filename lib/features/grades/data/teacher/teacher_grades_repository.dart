import 'package:MySchool/features/grades/data/teacher/teacher_grades_web_services.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';

class TeacherGradesRepository {
  final TeacherGradesWebServices teacherGradesWebServices;

  TeacherGradesRepository({required this.teacherGradesWebServices});
  Future<List<StudentResult>> getStudentGrades() async {
    List grades = await teacherGradesWebServices.getStudentsGrades();
    List<StudentResult> gradesx = [];
    try {
      gradesx =
          grades.map((element) => StudentResult.fromJson(element)).toList();
    } catch (e) {
      print(e);
    }
    return gradesx;
  }

  saveGrade(StudentResult studentResult) async {
    final returnedResult = await teacherGradesWebServices.saveGrades(
      studentResult,
    );
    return returnedResult;
  }
}
