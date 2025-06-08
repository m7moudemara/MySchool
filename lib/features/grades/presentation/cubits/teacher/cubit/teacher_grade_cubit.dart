import 'package:MySchool/features/grades/data/teacher/teacher_grades_repository.dart';
import 'package:MySchool/features/grades/data/teacher/teacher_grades_web_services.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'teacher_grade_state.dart';

class TeacherGradeCubit extends Cubit<TeacherGradeState> {
  TeacherGradeCubit() : super(TeacherGradeInitial());
  late List<StudentResult> listOfGrades;
  Future<void> loadGrades() async {
    emit(TeacherGradeLoading());
    try {
      print('ssssssssssss');
      final TeacherGradesRepository teacherGradesRepository =
          TeacherGradesRepository(
            teacherGradesWebServices: TeacherGradesWebServices(),
          );
      await Future.delayed(Duration(seconds: 2));
      print('ddddddddddddd');
      listOfGrades = await teacherGradesRepository.getStudentGrades();

      //       List<StudentResult> grades =
      // await teacherGradesRepository.getStudentGrades();
      // final result = await getGradesUseCase(term);
      emit(TeacherGradeLoaded(studentResults: listOfGrades));
    } catch (e) {
      emit(TeacherGradeError(message: 'Failed to load result'));
    }
  }

  selectTerm(String term, String subjectName) async {
    late List<StudentResult> sv;
    if (term == 'First') {
      sv =
          listOfGrades
              .where(
                (item) => item.term == 1 && item.subjectName == subjectName,
              )
              .toList();
      emit(TeacherGradeLoaded(studentResults: sv));
    } else {
      sv =
          listOfGrades
              .where(
                (item) => item.term == 2 && item.subjectName == subjectName,
              )
              .toList();
      emit(TeacherGradeLoaded(studentResults: sv));
    }
  }

  saveGrade(List<StudentResult> studentResults) {
    final TeacherGradesRepository teacherGradesRepository =
        TeacherGradesRepository(
          teacherGradesWebServices: TeacherGradesWebServices(),
        );

    try {
      for (var item in studentResults) {
        teacherGradesRepository.saveGrade(item);
      }
    } catch (e) {
      emit(TeacherGradeError(message: '$e'));
    }
  }
}
