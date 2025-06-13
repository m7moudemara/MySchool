// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/class_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_web_services.dart';

class ClassesRepository {
  final ClassesWebServices classesWebServices;
  ClassesRepository({required this.classesWebServices});

  Future<List<ClassStudentModel>> getClasses() async {
    List<ClassStudentModel> resultClasses = [];
    try {
      List result = await classesWebServices.getClasses();
      resultClasses =
          result.map((element) => ClassStudentModel.fromJson(element)).toList();
      return resultClasses;
    } catch (e) {
      print(e);
      return resultClasses;
    }
  }

  Future<List<TeacherAttendanceForStudent>> getAttendance(int classId) async {
    List result = await classesWebServices.getAttendance(classId);
    List<TeacherAttendanceForStudent> resultData = [];
    try {
      resultData =
          result
              .map((element) => TeacherAttendanceForStudent.fromJson(element))
              .toList();
    } catch (e) {
      print(e);
    }
    return resultData;
  }

  saveAttendance(int studentId, int classId, String status) async {
    try {
      await classesWebServices.saveAttendance(studentId, classId, status);
    } catch (e) {
      print(e);
    }
  }

  updateAttendance(int studentId, int classId, String status, int attId) async {
    try {
      await classesWebServices.updateAttendance(
        studentId,
        classId,
        status,
        attId,
      );
    } catch (e) {
      print(e);
    }
  }
}
