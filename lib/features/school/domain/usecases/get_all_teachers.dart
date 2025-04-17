// lib/features/users/domain/usecases/get_all_teachers.dart


import 'package:MySchool/features/school/domain/entities/user_type.dart';

import '../repositories/user_repository.dart';

class GetAllTeachers {
  final UserRepository repository;

  GetAllTeachers(this.repository);

  Future<List<IUser>> call() async {
    return await repository.getAllTeachers();
  }
}
