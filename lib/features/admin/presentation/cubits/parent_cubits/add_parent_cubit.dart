import 'package:MySchool/features/admin/domain/usecases/add_parent_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';

class AddParentState {
  final List<ParentEntity> parents;
  final bool isLoading;
  const AddParentState({required this.parents, this.isLoading = false});
}

class AddParentCubit extends Cubit<AddParentState> {
  final GetParentsUseCase getAll;
  final AddParentUseCase add;
  final UpdateParentUseCase update;
  final DeleteParentUseCase delete;

  AddParentCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(const AddParentState(parents: []));

  Future<void> loadParents() async {
    emit(const AddParentState(parents: [], isLoading: true));
    final list = await getAll();
    emit(AddParentState(parents: list));
  }

  Future<void> addParent(ParentEntity parent) async {
    await add(parent);
    await loadParents();
  }

  Future<void> updateParent(ParentEntity parent) async {
    await update(parent);
    await loadParents();
  }

  Future<void> deleteParent(String id) async {
    await delete(id);
    await loadParents();
  }
}
