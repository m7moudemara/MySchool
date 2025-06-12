import 'package:MySchool/features/admin/domain/entities/class_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/class_repository.dart';

class GetClassesUseCase {
  final ClassRepository repository;
  GetClassesUseCase(this.repository);
  Future<List<ClassEntity>> call() => repository.getAllClasses();
}

class AddClassUseCase {
  final ClassRepository repository;
  AddClassUseCase(this.repository);
  Future<void> call(ClassEntity newClass) => repository.addClass(newClass);
}

class UpdateClassUseCase {
  final ClassRepository repository;
  UpdateClassUseCase(this.repository);
  Future<void> call(ClassEntity updatedClass) => repository.updateClass(updatedClass);
}

class DeleteClassUseCase {
  final ClassRepository repository;
  DeleteClassUseCase(this.repository);
  Future<void> call(String id) => repository.deleteClass(id);
}
