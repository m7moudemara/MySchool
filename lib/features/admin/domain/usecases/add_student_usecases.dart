import 'package:MySchool/features/admin/domain/entities/student_entity.dart';
import '../repositories/student_repository.dart';

class GetStudentUseCase {
  final StudentRepository repo;
  GetStudentUseCase(this.repo);
  Future<List<StudentEntity>> call() => repo.getAllStudents();
}

class AddStudentUseCase {
  final StudentRepository repo;
  AddStudentUseCase(this.repo);
  Future<void> call(StudentEntity student) => repo.addStudent(student);
}

class UpdateStudentUseCase {
  final StudentRepository repo;
  UpdateStudentUseCase(this.repo);
  Future<void> call(StudentEntity student) => repo.updateStudent(student);
}

class DeleteStudentUseCase {
  final StudentRepository repo;
  DeleteStudentUseCase(this.repo);
  Future<void> call(String id) => repo.deleteStudent(id);
}
