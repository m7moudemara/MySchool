import 'package:MySchool/features/school/data/models/student_model.dart';

abstract class GetChildrenUseCase {
  Future<List<Student>> execute({required String parentId});
}
