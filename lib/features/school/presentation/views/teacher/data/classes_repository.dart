// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:MySchool/features/school/presentation/views/teacher/data/class_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_web_services.dart';

class ClassesRepository {
  final ClassesWebServices classesWebServices;
  ClassesRepository({required this.classesWebServices});

  Future<List<ClassStudentModel>> getClasses() async {
    List result = await classesWebServices.getClasses();
    List<ClassStudentModel> resultClasses =
        result.map((element) => ClassStudentModel.fromJson(element)).toList();
    return resultClasses;
  }
}
