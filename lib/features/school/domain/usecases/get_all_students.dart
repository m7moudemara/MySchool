// domain/usecases/get_all_students.dart



import 'package:MySchool/features/school/domain/entities/user_type.dart';

import '../repositories/user_repository.dart';

class GetAllStudents {
  final UserRepository repository;

  GetAllStudents(this.repository);

  Future<List<IUser>> call() async {
    return await repository.getAllStudents();
  }
}
