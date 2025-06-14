import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';
import '../repositories/parent_respository.dart';

class GetParentsUseCase {
  final ParentRepository repo;
  GetParentsUseCase(this.repo);
  Future<List<ParentEntity>> call() => repo.getAllParents();
}

class AddParentUseCase {
  final ParentRepository repo;
  AddParentUseCase(this.repo);
  Future<void> call(ParentEntity parent) => repo.addParent(parent);
}

class UpdateParentUseCase {
  final ParentRepository repo;
  UpdateParentUseCase(this.repo);
  Future<void> call(ParentEntity parent) => repo.updateParent(parent);
}

class DeleteParentUseCase {
  final ParentRepository repo;
  DeleteParentUseCase(this.repo);
  Future<void> call(String id) => repo.deleteParent(id);
}
