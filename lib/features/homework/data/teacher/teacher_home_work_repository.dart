import 'package:MySchool/features/homework/data/homework_model.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_class_model.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_home_work_web_services.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_subject_model.dart';

class TeacherHomeWorkRepository {
  TeacherHomeWorkWebServices teacherHomeWorkWebServices;

  TeacherHomeWorkRepository(this.teacherHomeWorkWebServices);
  Future<List<TeacherClassModel>> fetchTeacherClasses() async {
    List<Map<String, dynamic>> result =
        await teacherHomeWorkWebServices.fetchTeacherClasses();
    List<TeacherClassModel> resultx =
        result.map((element) => TeacherClassModel.fromJson(element)).toList();
    return resultx;
  }

  Future<List<TeacherSubjectModel>> fetchTeacherSubjects() async {
    List<Map<String, dynamic>> result =
        await teacherHomeWorkWebServices.fetchTeacherSubjects();
    List<TeacherSubjectModel> resultx =
        result.map((element) => TeacherSubjectModel.fromJson(element)).toList();
    return resultx;
  }

  Future<List<HomeworkModel>> fetchTeacherHomeWorks() async {
    List<Map<String, dynamic>> result =
        await teacherHomeWorkWebServices.fetchTeacherHomeWorks();
    List<HomeworkModel> resultx =
        result.map((element) => HomeworkModel.fromJson(element)).toList();
    return resultx;
  }

  deleteHomeWork(int id) async {
    await teacherHomeWorkWebServices.deleteHomeWork(id);
  }
}
