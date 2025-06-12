import 'package:MySchool/features/admin/data/models/subjects.dart';

abstract class SubjectsLocalDataSource {
  Future<List<Subjects>> getAll();
  Future<void> add(Subjects model);
  Future<void> update(Subjects model);
  Future<void> delete(String id);
}
