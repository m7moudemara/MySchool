import 'package:MySchool/features/admin/data/models/add_parent_model.dart';

abstract class ParentLocalDataSource {
  Future<List<AddParentsModel>> getAll();
  Future<void> add(AddParentsModel parent);
  Future<void> update(AddParentsModel parent);
  Future<void> delete(String id);
}

