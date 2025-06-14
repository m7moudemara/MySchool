import 'package:MySchool/features/admin/data/models/add_class_model.dart';

abstract class ClassLocalDataSource {
  Future<List<AddClassModel>> getAll();
  Future<void> add(AddClassModel model);
  Future<void> update(AddClassModel model);
  Future<void> delete(String id);
}
