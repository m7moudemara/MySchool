import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';

abstract class TeacherLocalDataSource {
  Future<List<AddTeachersModel>> getAll();
  Future<void> add(AddTeachersModel teacher);
  Future<void> update(AddTeachersModel teacher);
  Future<void> delete(String id);
}
