import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';

abstract class TeacherLocalDataSource {
  Future<List<AddTeachersModel>> getAll();
  Future<void> add(AddTeachersModel teacher);
  Future<void> update(AddTeachersModel teacher);
  Future<void> delete(String id);
}

// implementation
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
