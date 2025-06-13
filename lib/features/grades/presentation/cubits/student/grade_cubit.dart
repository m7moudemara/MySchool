import 'package:MySchool/features/grades/domain/usecases/get_grades_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grade_state.dart';

class GradeCubit extends Cubit<ResultState> {
  final GetGradesUseCase getGradesUseCase;

  GradeCubit(this.getGradesUseCase) : super(ResultInitial());

  Future<void> loadGrades(String term, int studentId) async {
    emit(ResultLoading());
    try {
      final result = await getGradesUseCase(term, studentId);
      emit(ResultLoaded(result));
    } catch (e) {
      emit(ResultError("Failed to load result"));
    }
  }
}
