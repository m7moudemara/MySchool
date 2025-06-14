import 'package:MySchool/features/admin/data/data_sources/teacher_data_sources/teacher_local_datasource.dart';
import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';
import 'package:MySchool/features/admin/domain/entities/teacher_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/teacher_repository.dart';

class TeachersRepositoryImpl implements TeacherRepository {
  final TeacherLocalDataSource local;

  TeachersRepositoryImpl(this.local);

  @override
  Future<void> addTeacher(TeacherEntity teacher) {
    return local.add(AddTeachersModel.fromEntity(teacher));
  }

  @override
  Future<void> deleteTeacher(String id) => local.delete(id);

  @override
  Future<List<TeacherEntity>> getAllTeachers() async => local.getAll();

  @override
  Future<void> updateTeacher(TeacherEntity teacher) {
    return local.update(AddTeachersModel.fromEntity(teacher));
  }
}
