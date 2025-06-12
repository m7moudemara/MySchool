// presentation/cubits/add_teacher_cubit.dart
import 'package:MySchool/features/admin/domain/usecases/add_teacher_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/admin/domain/entities/teacher_entity.dart';

class AddTeacherState {
  final List<TeacherEntity> teachers;
  final bool isLoading;
  const AddTeacherState({required this.teachers, this.isLoading = false});
}

class AddTeacherCubit extends Cubit<AddTeacherState> {
  final GetTeachersUseCase getAll;
  final AddTeacherUseCase add;
  final UpdateTeacherUseCase update;
  final DeleteTeacherUseCase delete;

  AddTeacherCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(const AddTeacherState(teachers: []));

  Future<void> loadTeachers() async {
    emit(const AddTeacherState(teachers: [], isLoading: true));
    final list = await getAll();
    emit(AddTeacherState(teachers: list));
  }

  Future<void> addTeacher(TeacherEntity teacher) async {
    await add(teacher);
    await loadTeachers();
  }

  Future<void> updateTeacher(TeacherEntity teacher) async {
    await update(teacher);
    await loadTeachers();
  }

  Future<void> deleteTeacher(String id) async {
    await delete(id);
    await loadTeachers();
  }
}
