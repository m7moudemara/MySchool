import 'package:MySchool/features/school/presentation/views/teacher/data/class_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_repository.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_web_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../student/data/attendance_model.dart';
part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit() : super(ClassesInitial());

  void getClasses() async {
    emit(ClassesLoading());
    try {
      ClassesRepository classesRepository = ClassesRepository(
        classesWebServices: ClassesWebServices(),
      );
      Future.delayed(Duration(seconds: 2));
      List<ClassStudentModel> classes = await classesRepository.getClasses();
      print(classes);

      List<TeacherAttendanceForStudent> attendances = await classesRepository
          .getAttendance(classes[0].classId);
      print(attendances);
      emit(ClassesLoaded(classes, attendances));
    } catch (e) {
      emit(ClassesLoadedError(message: 'there is an error'));
    }
  }

  void getClassesx(int classId) async {
    emit(ClassesLoading());
    try {
      ClassesRepository classesRepository = ClassesRepository(
        classesWebServices: ClassesWebServices(),
      );
      Future.delayed(Duration(seconds: 2));
      List<ClassStudentModel> classes = await classesRepository.getClasses();
      List<TeacherAttendanceForStudent> attendances = await classesRepository
          .getAttendance(classId);
      emit(ClassesLoaded2(classes, attendances));
    } catch (e) {
      emit(ClassesLoadedError(message: 'there is an error'));
    }
  }

  saveAttendance(
    List<TeacherAttendanceForStudent> updated,
    List<TeacherAttendanceForStudent> savedAbsent,
    List<TeacherAttendanceForStudent> savedPresent,
    int selectedClassId,
  ) {
    ClassesRepository classesRepository = ClassesRepository(
      classesWebServices: ClassesWebServices(),
    );
    // print(updated.length);
    // print(savedAbsent.length);
    // print(savedPresent.length);
    if (updated.isNotEmpty) {
      for (var element in updated) {
        if (element.attendanceModel!.status == 'Present') {
          classesRepository.updateAttendance(
            element.student.id,
            selectedClassId,
            'Absent',
            element.attendanceModel!.id,
          );
        } else {
          classesRepository.updateAttendance(
            element.student.id,
            selectedClassId,
            'Present',
            element.attendanceModel!.id,
          );
        }
      }
    }
    if (savedAbsent.isNotEmpty) {
      for (var element in savedAbsent) {
        classesRepository.saveAttendance(
          element.student.id,
          selectedClassId,
          'Absent',
        );
      }
    }
    if (savedPresent.isNotEmpty) {
      for (var element in savedPresent) {
        classesRepository.saveAttendance(
          element.student.id,
          selectedClassId,
          'Present',
        );
      }
    }

    // for (var i.student.id,
    //       seltem in attendances) {
    //   if (item.attendanceModel == null) {
    //     classesRepository.saveAttendance(
    //       item.student.id,
    //       selectedClassId,
    //       'Absent',
    //     );
    //   } else {
    //     classesRepository.saveAttendance(
    //       itemectedClassId,
    //       'Absent',
    //     );
    //   }
    // }
  }
}
