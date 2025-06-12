import 'package:MySchool/features/admin/data/models/add_fees_model.dart';

abstract class FeesLocalDataSource {
  Future<List<AddFeesModel>> getAll();
  Future<void> add(AddFeesModel model);
  Future<void> update(AddFeesModel model);
  Future<void> delete(String id);
}
