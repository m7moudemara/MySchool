import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_class_model.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_home_work_repository.dart';
import 'package:MySchool/features/homework/data/teacher/teacher_home_work_web_services.dart';
import 'package:MySchool/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../teacher_subject_model.dart';

part 'teacher_home_work_state.dart';

class TeacherHomeWorkCubit extends Cubit<TeacherHomeWorkState> {
  TeacherHomeWorkCubit() : super(TeacherHomeWorkInitial());
  final homeworkTitleController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  fetchTeacherClasses() async {
    emit(TeacherClassLoading());
    try {
      Future.delayed(Duration(seconds: 2));
      TeacherHomeWorkRepository teacherHomeWorkRepository =
          TeacherHomeWorkRepository(TeacherHomeWorkWebServices());
      List<TeacherClassModel> classes =
          await teacherHomeWorkRepository.fetchTeacherClasses();
      List<TeacherSubjectModel> subjects =
          await teacherHomeWorkRepository.fetchTeacherSubjects();
      emit(TeacherClassLoaded(classes: classes, subjects: subjects));
    } catch (e) {
      emit(TeacherClassError(message: '$e'));
    }
  }

  pushHomeWorkToServer({
    required PlatformFile plateFormFile,
    required TeacherSubjectModel subject,
    required TeacherClassModel classx,
    required DateTime deadline,
  }) async {
    final dio = getIt<Dio>();
    String? token = await sharedPrefController.getToken();
    FormData formData = FormData.fromMap({
      'attachment': await MultipartFile.fromFile(
        plateFormFile.path!,
        filename: plateFormFile.name,
      ),
      'mark': 0,
      'title': homeworkTitleController.text,
      'deadline': deadline.toUtc(),
      'is_active': true,
      'class_id': classx.id,
      'subject_id': subject.id,
    });

    try {
      Response response = await dio.post(
        '$baseUrl/api/assignments',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(HomeWorkUploaded('Upload successful'));
        homeworkTitleController.clear();
        print('Upload successful');
      } else {
        emit(HomeWorkUploadedError('Upload failed: ${response.statusCode}'));
        print('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      emit(HomeWorkUploadedError('Error during upload: $e'));
      print('Error during upload: $e');
    }
  }

}
