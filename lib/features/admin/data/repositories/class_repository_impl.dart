import '../../domain/entities/class_entity.dart';
import '../../domain/repositories/class_repository.dart';
import '../data_sources/class_data_sources/class_local_datasource.dart';
import '../models/class_model.dart';

class ClassRepositoryImpl implements ClassRepository {
  final ClassLocalDataSource localDataSource;
  ClassRepositoryImpl(this.localDataSource);

  @override
  Future<void> addClass(ClassEntity newClass) {
    return localDataSource.add(ClassModel(
      id: newClass.id,
      name: newClass.name,
      grade: newClass.grade,
      studentsCount: newClass.studentsCount,
    ));
  }

  @override
  Future<void> deleteClass(String id) {
    return localDataSource.delete(id);
  }

  @override
  Future<List<ClassEntity>> getAllClasses() {
    return localDataSource.getAll();
  }

  @override
  Future<void> updateClass(ClassEntity updatedClass) {
    return localDataSource.update(ClassModel(
      id: updatedClass.id,
      name: updatedClass.name,
      grade: updatedClass.grade,
      studentsCount: updatedClass.studentsCount,
    ));
  }
}
