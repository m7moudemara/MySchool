import 'package:MySchool/features/grades/data/teacher/teacher_grades_repository.dart';
import 'package:MySchool/features/grades/data/teacher/teacher_grades_web_services.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_home_work_repository.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_home_work_web_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../homework/data/teacher/teacher_subject_model.dart';
import 'teacher_grade_state.dart';

class TeacherGradeCubit extends Cubit<TeacherGradeState> {
  TeacherGradeCubit() : super(TeacherGradeInitial());

  // late List<TeacherResultModel> listOfGrades;

  Future<void> loadGrades() async {
    emit(TeacherGradeLoading());
    try {
      final TeacherGradesRepository teacherGradesRepository =
          TeacherGradesRepository(
            teacherGradesWebServices: TeacherGradesWebServices(),
          );
      await Future.delayed(Duration(seconds: 2));
      List<TeacherSubjectModel> subjects =
          await teacherGradesRepository.fetchTeacherSubjects();
      List<TeacherResultModel> listOfGrades = await teacherGradesRepository
          .getStudentGrades(subjects[0].id, 1);
      emit(
        TeacherGradeLoaded(studentResults: listOfGrades, subjects: subjects),
      );
    } catch (e) {
      emit(TeacherGradeError(message: 'Failed to load result'));
    }
  }

  Future<void> loadGrades2(int subjectId, int term) async {
    emit(TeacherGradeLoading());
    try {
      final TeacherGradesRepository teacherGradesRepository =
          TeacherGradesRepository(
            teacherGradesWebServices: TeacherGradesWebServices(),
          );
      await Future.delayed(Duration(seconds: 2));
      List<TeacherSubjectModel> subjects =
          await teacherGradesRepository.fetchTeacherSubjects();
      List<TeacherResultModel> listOfGrades = await teacherGradesRepository
          .getStudentGrades(subjectId, term);
      emit(
        TeacherGradeLoaded(studentResults: listOfGrades, subjects: subjects),
      );
    } catch (e) {
      emit(TeacherGradeError(message: 'Failed to load result'));
    }
  }

  fetchTeacherSubjects() async {
    final TeacherHomeWorkRepository teacherHomeWorkRepository =
        TeacherHomeWorkRepository(TeacherHomeWorkWebServices());
    emit(SubjectsLoading());
    try {
      Future.delayed(Duration(seconds: 2));
      List<TeacherSubjectModel> subjects =
          await teacherHomeWorkRepository.fetchTeacherSubjects();
      emit(SubjectsLoaded(subjects: subjects));
    } catch (e) {
      print(e);
    }
  }

  saveGrade(List<TeacherResultModel> studentResults) {
    final TeacherGradesRepository teacherGradesRepository =
        TeacherGradesRepository(
          teacherGradesWebServices: TeacherGradesWebServices(),
        );

    try {
      for (var item in studentResults) {
        if (item.studentResult != null) {
          if (item.studentResult!.id == 0) {
            teacherGradesRepository.saveGrades(item.studentResult!);
          } else {
            teacherGradesRepository.updateGrades(item.studentResult!);
          }
        }
      }
    } catch (e) {
      emit(TeacherGradeError(message: '$e'));
    }
  }
}
