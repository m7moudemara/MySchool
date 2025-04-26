import 'package:MySchool/features/grades/data/models/subject_model.dart';
import 'package:MySchool/features/grades/domain/usecases/get_grades_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part  'grade_state.dart';


class GradeCubit extends Cubit<GradesState> {
  final GetGradesUseCase getGradesUseCase;

  GradeCubit(this.getGradesUseCase) : super(GradesInitial());

  Future<void> fetchGrades(String studentId) async {
    emit(GradesLoading());
    try {
      final grades = await getGradesUseCase(studentId);
      emit(GradesLoaded([grades]));
    } catch (e) {
      emit(GradesError("Something went wrong: $e"));
    }
  }
}
