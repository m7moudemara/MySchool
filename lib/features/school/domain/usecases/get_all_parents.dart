// domain/usecases/get_all_parents.dart


import 'package:MySchool/features/school/domain/entities/user_type.dart';

import '../repositories/user_repository.dart';

class GetAllParents {
  final UserRepository repository;

  GetAllParents(this.repository);

  Future<List<IUser>> call() async {
    return await repository.getAllParents();
  }
}
