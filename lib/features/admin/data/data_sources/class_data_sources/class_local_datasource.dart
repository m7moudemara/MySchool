import 'package:MySchool/features/admin/data/models/class_model.dart';

abstract class ClassLocalDataSource {
  Future<List<ClassModel>> getAll();
  Future<void> add(ClassModel model);
  Future<void> update(ClassModel model);
  Future<void> delete(String id);
}
