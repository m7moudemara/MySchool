import '../entities/teacher_entity.dart';
import '../repositories/teacher_repository.dart';

class GetTeachersUseCase {
  final TeacherRepository repo;
  GetTeachersUseCase(this.repo);
  Future<List<TeacherEntity>> call() => repo.getAllTeachers();
}

class AddTeacherUseCase {
  final TeacherRepository repo;
  AddTeacherUseCase(this.repo);
  Future<void> call(TeacherEntity teacher) => repo.addTeacher(teacher);
}

class UpdateTeacherUseCase {
  final TeacherRepository repo;
  UpdateTeacherUseCase(this.repo);
  Future<void> call(TeacherEntity teacher) => repo.updateTeacher(teacher);
}

class DeleteTeacherUseCase {
  final TeacherRepository repo;
  DeleteTeacherUseCase(this.repo);
  Future<void> call(String id) => repo.deleteTeacher(id);
}
