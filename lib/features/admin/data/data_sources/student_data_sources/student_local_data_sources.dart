import 'package:MySchool/features/admin/data/models/add_student_model.dart';

abstract class StudentLocalDataSource {
  Future<List<AddStudentModel>> getAll();
  Future<void> add(AddStudentModel student);
  Future<void> update(AddStudentModel student);
  Future<void> delete(String id);
}

