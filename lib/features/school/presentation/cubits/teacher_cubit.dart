// lib/features/users/presentation/cubit/teacher_cubit.dart

import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_teachers.dart';

class TeacherCubit extends Cubit<List<IUser>> {
  final GetAllTeachers getAllTeachers;

  TeacherCubit(this.getAllTeachers) : super([]);

  void loadTeachers() async {
    final teachers = await getAllTeachers();
    emit(teachers);
  }
}
