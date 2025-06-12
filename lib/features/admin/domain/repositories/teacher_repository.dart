// domain/repositories/teacher_repository.dart
import '../entities/teacher_entity.dart';

abstract class TeacherRepository {
  Future<List<TeacherEntity>> getAllTeachers();
  Future<void> addTeacher(TeacherEntity teacher);
  Future<void> updateTeacher(TeacherEntity teacher);
  Future<void> deleteTeacher(String id);
}
