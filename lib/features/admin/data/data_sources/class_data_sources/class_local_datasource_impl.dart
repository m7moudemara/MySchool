import '../../models/class_model.dart';
import 'class_local_datasource.dart';

class ClassLocalDataSourceImpl implements ClassLocalDataSource {
  final List<ClassModel> _classes = [];

  @override
  Future<List<ClassModel>> getAll() async => _classes;

  @override
  Future<void> add(ClassModel newClass) async {
    _classes.add(newClass);
  }

  @override
  Future<void> update(ClassModel updatedClass) async {
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
