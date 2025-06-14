import '../entities/parent_entity.dart';

abstract class ParentRepository {
  Future<List<ParentEntity>> getAllParents();
  Future<void> addParent(ParentEntity parent);
  Future<void> updateParent(ParentEntity parent);
  Future<void> deleteParent(String id);
}
