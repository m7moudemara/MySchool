

import 'package:MySchool/features/admin/data/data_sources/teacher_data_sources/teacher_local_datasource.dart';
import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';

class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
  final List<AddTeachersModel> _teachers = [];

  @override
  Future<List<AddTeachersModel>> getAll() async => _teachers;

  @override
  Future<void> add(AddTeachersModel teacher) async => _teachers.add(teacher);

  @override
  Future<void> update(AddTeachersModel updated) async {
    final index = _teachers.indexWhere((t) => t.id == updated.id);
    if (index != -1) _teachers[index] = updated;
  }

  @override
  Future<void> delete(String id) async {
    _teachers.removeWhere((t) => t.id == id);
  }
}
