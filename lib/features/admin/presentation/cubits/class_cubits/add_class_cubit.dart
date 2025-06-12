import 'package:MySchool/features/admin/domain/entities/class_entity.dart';
import 'package:MySchool/features/admin/domain/usecases/add_class_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClassState {
  final List<ClassEntity> classes;
  final bool isLoading;

  AddClassState({required this.classes, this.isLoading = false});
}

class AddClassCubit extends Cubit<AddClassState> {
  final GetClassesUseCase getAll;
  final AddClassUseCase add;
  final UpdateClassUseCase update;
  final DeleteClassUseCase delete;

  AddClassCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(AddClassState(classes: []));

  void loadClasses() async {
    emit(AddClassState(classes: [], isLoading: true));
    final result = await getAll();
    emit(AddClassState(classes: result));
  }

  void addClass(ClassEntity entity) async {
    await add(entity);
    loadClasses();
  }

  void updateClass(ClassEntity entity) async {
    await update(entity);
    loadClasses();
  }

  void deleteClass(String id) async {
    await delete(id);
    loadClasses();
  }
}
