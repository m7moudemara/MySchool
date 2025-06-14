import 'package:MySchool/features/admin/data/models/add_subjects_model.dart';

abstract class SubjectsLocalDataSource {
  Future<List<AddSubjectsModel>> getAll();
  Future<void> add(AddSubjectsModel model);
  Future<void> update(AddSubjectsModel model);
  Future<void> delete(String id);
}
