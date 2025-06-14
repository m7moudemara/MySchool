import 'package:MySchool/features/admin/domain/usecases/add_student_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/admin/domain/entities/student_entity.dart';

class AddStudentState {
  final List<StudentEntity> students;
  final bool isLoading;
  const AddStudentState({required this.students, this.isLoading = false});
}

class AddStudentCubit extends Cubit<AddStudentState> {
  final GetStudentUseCase getAll;
  final AddStudentUseCase add;
  final UpdateStudentUseCase update;
  final DeleteStudentUseCase delete;

  AddStudentCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(const AddStudentState(students: []));

  Future<void> loadStudents() async {
    emit(const AddStudentState(students: [], isLoading: true));
    final list = await getAll();
    emit(AddStudentState(students: list));
  }

  Future<void> addStudent(StudentEntity student) async {
    await add(student);
    await loadStudents();
  }

  Future<void> updateStudent(StudentEntity student) async {
    await update(student);
    await loadStudents();
  }

  Future<void> deleteStudent(String id) async {
    await delete(id);
    await loadStudents();
  }
}
