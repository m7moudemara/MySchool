import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_student_model.dart';
import 'package:MySchool/features/admin/domain/entities/student_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentLocalDataSource local;

  StudentRepositoryImpl(this.local);

  @override
  Future<void> addStudent(StudentEntity student) {
    return local.add(AddStudentModel.fromEntity(student));
  }

  @override
  Future<void> deleteStudent(String id) => local.delete(id);

  @override
  Future<List<StudentEntity>> getAllStudents() async => local.getAll();

  @override
  Future<void> updateStudent(StudentEntity student) {
    return local.update(AddStudentModel.fromEntity(student));
  }
}
