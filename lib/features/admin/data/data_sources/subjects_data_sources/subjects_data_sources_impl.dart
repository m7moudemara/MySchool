import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_subjects_model.dart';

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final List<AddSubjectsModel> _subjects = [];

  @override
  Future<List<AddSubjectsModel>> getAll() async => _subjects;

  @override
  Future<void> add(AddSubjectsModel newSubject) async {
    _subjects.add(newSubject);
  }

  @override
  Future<void> update(AddSubjectsModel updatedSubject) async {
    final index = _subjects.indexWhere((c) => c.id == updatedSubject.id);
    if (index != -1) {
      _subjects[index] = updatedSubject;
    }
  }

  @override
  Future<void> delete(String id) async {
    _subjects.removeWhere((c) => c.id == id);
  }
}
