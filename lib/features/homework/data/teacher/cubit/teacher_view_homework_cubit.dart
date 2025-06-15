import 'package:MySchool/features/homework/data/home_work_repository.dart';
import 'package:MySchool/features/homework/data/home_work_webservices.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_web_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../school/presentation/views/teacher/data/class_model.dart';
import '../../../../school/presentation/views/teacher/data/classes_repository.dart';
import '../../homework_model.dart';
import '../teacher_home_work_repository.dart';
import '../teacher_home_work_web_services.dart';

part 'teacher_view_homework_state.dart';

class TeacherViewHomeworkCubit extends Cubit<TeacherViewHomeworkState> {
  TeacherViewHomeworkCubit() : super(TeacherViewHomeworkInitial());

  fetchTeacherHomeWorks() async {
    emit(HomeWorksLoading());
    TeacherHomeWorkRepository teacherHomeWorkRepository =
        TeacherHomeWorkRepository(TeacherHomeWorkWebServices());
    try {
      Future.delayed(Duration(seconds: 2));
      List<HomeworkModel> homeWorks =
          await teacherHomeWorkRepository.fetchTeacherHomeWorks();
      emit(HomeWorksLoaded(homeWorks: homeWorks));
    } catch (e) {
      emit(HomeWorksError(message: '$e'));
    }
  }

  deleteHomeWork(int id) async {
    // emit(HomeWorksLoading());
    TeacherHomeWorkRepository teacherHomeWorkRepository =
        TeacherHomeWorkRepository(TeacherHomeWorkWebServices());
    try {
      Future.delayed(Duration(seconds: 2));
      await teacherHomeWorkRepository.deleteHomeWork(id);
    } catch (e) {
      emit(HomeWorksError(message: '$e'));
    }
  }

  getSubmissions(int homeWorkId, int classId) async {
    HomeWorkRepository teacherHomeWorkRepository = HomeWorkRepository(
      HomeWorkWebservices(),
    );
    ClassesRepository classesRepository = ClassesRepository(
      classesWebServices: ClassesWebServices(),
    );
    emit(HomeWorksLoading());
    Future.delayed(Duration(seconds: 2));
    try {
      List<StudentHomeWorkResult> homWorks = await teacherHomeWorkRepository
          .getSubmissions(homeWorkId);
      List<ClassStudentModel> students = await classesRepository.getClasses();
      List<ClassStudentModel> studentsx =
          students.where((element) => element.classId == classId).toList();
      emit(
        HomeWorksSubmissionsLoaded(homeWorks: homWorks, students: studentsx),
      );
    } catch (e) {
      print(e);
    }
  }

  getStudentClass() async {
    ClassesRepository classesRepository = ClassesRepository(
      classesWebServices: ClassesWebServices(),
    );
  }
}
