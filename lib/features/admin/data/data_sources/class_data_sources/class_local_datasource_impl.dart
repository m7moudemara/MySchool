import '../../models/add_class_model.dart';
import 'class_local_datasource.dart';

class ClassLocalDataSourceImpl implements ClassLocalDataSource {
  final List<AddClassModel> _classes = [];

  @override
  Future<List<AddClassModel>> getAll() async => _classes;

  @override
  Future<void> add(AddClassModel newClass) async {
    _classes.add(newClass);
  }

  @override
  Future<void> update(AddClassModel updatedClass) async {
    final index = _classes.indexWhere((c) => c.id == updatedClass.id);
    if (index != -1) {
      _classes[index] = updatedClass;
    }
  }

  @override
  Future<void> delete(String id) async {
    _classes.removeWhere((c) => c.id == id);
  }
}
