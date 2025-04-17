
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_students.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StudentCubit extends Cubit<List<IUser>> {
  final GetAllStudents getAllStudents;

  StudentCubit(this.getAllStudents) : super([]);

  void loadStudents() async {
    final students = await getAllStudents();
    emit(students);
  }
}
