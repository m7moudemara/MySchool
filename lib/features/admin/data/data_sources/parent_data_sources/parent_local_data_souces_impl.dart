
import 'package:MySchool/features/admin/data/data_sources/parent_data_sources/parent_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_parent_model.dart';

class ParentLocalDataSourceImpl implements ParentLocalDataSource {
  final List<AddParentsModel> _parents = [];

  @override
  Future<List<AddParentsModel>> getAll() async => _parents;

  @override
  Future<void> add(AddParentsModel parent) async => _parents.add(parent);

  @override
  Future<void> update(AddParentsModel updated) async {
    final index = _parents.indexWhere((t) => t.id == updated.id);
    if (index != -1) _parents[index] = updated;
  }

  @override
  Future<void> delete(String id) async {
    _parents.removeWhere((t) => t.id == id);
  }
}
