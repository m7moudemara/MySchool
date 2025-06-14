import '../entities/student_entity.dart';

abstract class StudentRepository {
  Future<List<StudentEntity>> getAllStudents();
  Future<void> addStudent(StudentEntity student);
  Future<void> updateStudent(StudentEntity student);
  Future<void> deleteStudent(String id);
}
