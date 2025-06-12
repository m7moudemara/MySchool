import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';

abstract class SubjectRepository {
  Future<List<SubjectEntity>> getSubjects();
  Future<void> addSubject(SubjectEntity classEntity);
  Future<void> updateSubject(SubjectEntity classEntity);
  Future<void> deleteSubject(String id);
}
