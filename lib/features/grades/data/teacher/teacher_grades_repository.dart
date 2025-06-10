import 'package:MySchool/features/grades/data/teacher/teacher_grades_web_services.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';

import '../../../homework/data/teacher/teacher_subject_model.dart';

class TeacherGradesRepository {
  final TeacherGradesWebServices teacherGradesWebServices;

  TeacherGradesRepository({required this.teacherGradesWebServices});

  Future<List<TeacherSubjectModel>> fetchTeacherSubjects() async {
    List<Map<String, dynamic>> result =
        await teacherGradesWebServices.fetchTeacherSubjects();
    List<TeacherSubjectModel> resultx =
        result.map((element) => TeacherSubjectModel.fromJson(element)).toList();
    return resultx;
  }

  Future<List<TeacherResultModel>> getStudentGrades(int subjectId, int term) async {
    // print('alaa');
    List<Map<String, dynamic>> grades =
        await teacherGradesWebServices.getStudentsGrades(subjectId, term);
    // print(grades);
    // print(grades['grades']);
    // print('-------------------');
    List<TeacherResultModel> teacherResults =
        grades
            .map((item) => TeacherResultModel.fromJson(item))
            .toList();
    // print(teacherResults);
    // print('A7aaaaaaaa');
    // print(grades);
    // print('vvvvvvvvvvvvvvvvvvv');
    // List<TeacherResultModel> gradesx = [];
    // try {
    //   gradesx =
    //       grades
    //           .map((element) => TeacherResultModel.fromJson(element))
    //           .toList();
    //   print(gradesx);
    //   print('wewewewewew');
    // } catch (e) {
    //   print(e);
    // }
    return teacherResults;
  }

  updateGrades(StudentResult studentResult) async {
    final returnedResult = await teacherGradesWebServices.updateGrades(
      studentResult,
    );
    return returnedResult;
  }
    saveGrades(StudentResult studentResult) async {
    final returnedResult = await teacherGradesWebServices.saveGrades(
      studentResult,
    );
    return returnedResult;
  }
}
