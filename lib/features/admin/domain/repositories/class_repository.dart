import 'package:MySchool/features/admin/domain/entities/class_entity.dart';

abstract class ClassRepository {
  Future<List<ClassEntity>> getAllClasses();
  Future<void> addClass(ClassEntity classEntity);
  Future<void> updateClass(ClassEntity classEntity);
  Future<void> deleteClass(String id);
}
