import 'package:MySchool/features/admin/data/data_sources/parent_data_sources/parent_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_parent_model.dart';
import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/parent_respository.dart';

class ParentsRepositoryImpl implements ParentRepository {
  final ParentLocalDataSource local;

  ParentsRepositoryImpl(this.local);

  @override
  Future<void> addParent(ParentEntity parent) {
    return local.add(AddParentsModel.fromEntity(parent));
  }

  @override
  Future<void> deleteParent(String id) => local.delete(id);

  @override
  Future<List<ParentEntity>> getAllParents() async => local.getAll();

  @override
  Future<void> updateParent(ParentEntity parent) {
    return local.update(AddParentsModel.fromEntity(parent));
  }
}
