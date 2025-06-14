
import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_student_model.dart';

class StudentLocalDataSourceImpl implements StudentLocalDataSource {
  final List<AddStudentModel> _students = [];

  @override
  Future<List<AddStudentModel>> getAll() async => _students;

  @override
  Future<void> add(AddStudentModel student) async => _students.add(student);

  @override
  Future<void> update(AddStudentModel updated) async {
    final index = _students.indexWhere((t) => t.id == updated.id);
    if (index != -1) _students[index] = updated;
  }

  @override
  Future<void> delete(String id) async {
    _students.removeWhere((t) => t.id == id);
  }
}
