
import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/subject_repository.dart';

class GetSubjectUseCase {
  final SubjectRepository repository;
  GetSubjectUseCase(this.repository);
  Future<List<SubjectEntity>> call() => repository.getSubjects();
}

class AddSubjectUseCase {
  final SubjectRepository repository;
  AddSubjectUseCase(this.repository);
  Future<void> call(SubjectEntity newSubject) => repository.addSubject(newSubject);
}

class UpdateSubjectUseCase {
  final SubjectRepository repository;
  UpdateSubjectUseCase(this.repository);
  Future<void> call(SubjectEntity updatedSubject) => repository.updateSubject(updatedSubject);
}

class DeleteSubjectUseCase {
  final SubjectRepository repository;
  DeleteSubjectUseCase(this.repository);
  Future<void> call(String id) => repository.deleteSubject(id);
}
