import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources.dart';
import 'package:MySchool/features/admin/data/models/subjects.dart';
import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/subject_repository.dart';

class SubjectsRepositoryImpl implements SubjectRepository {
  final SubjectsLocalDataSource localDataSource;
  SubjectsRepositoryImpl(this.localDataSource);

  @override
  Future<void> addSubject(SubjectEntity newSubject) {
    return localDataSource.add(Subjects(
      id: newSubject.id,
      name: newSubject.name,
    ));
  }

  @override
  Future<void> deleteSubject(String id) {
    return localDataSource.delete(id);
  }

  @override
  Future<List<SubjectEntity>> getSubjects() {
    return localDataSource.getAll();
  }

  @override
  Future<void> updateSubject(SubjectEntity updatedSubject) {
    return localDataSource.update(
      Subjects(id: updatedSubject.id, name: updatedSubject.name),
    );
  }
}
