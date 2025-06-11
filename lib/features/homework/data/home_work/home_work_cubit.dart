import 'package:MySchool/features/homework/data/home_work_repository.dart';
import 'package:MySchool/features/homework/data/home_work_webservices.dart';
import 'package:MySchool/features/homework/data/homework_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/strings.dart';
import '../../../../main.dart';
part 'home_work_state.dart';

class HomeWorkCubit extends Cubit<HomeWorkState> {
  HomeWorkCubit() : super(HomeWorkInitial());
  final homeworkTitleController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  void loadHomeWorks() {
    emit(HomeWorkLoading());
    try {
      HomeWorkRepository homeWorkRepository = HomeWorkRepository(
        homeWorkWebservices: HomeWorkWebservices(),
      );
      // Simulate a delay for loading
      Future.delayed(Duration(seconds: 1), () async {
        List<HomeworkModel> homeWorks =
            await homeWorkRepository.fetchAssignments();
        // print(homeWorks);
        emit(HomeWorkLoaded(homeWorks));
      });
    } catch (e) {
      emit(HomeWorkError("Failed to load homework assignments"));
    }
  }

  // submitAssignment({
  //   required int id,
  //   required PlatformFile plateFormFile,
  // }) async {
  //   emit(HomeWorkSubmittedLoading());
  //   Future.delayed(Duration(seconds: 2));
  //   Dio dio = Dio();
  //   String? token = await sharedPrefController.getToken();
  //   FormData formData = FormData.fromMap({
  //     'assignment ': await MultipartFile.fromFile(
  //       plateFormFile.path!,
  //       filename: plateFormFile.name,
  //     ),
  //   });

  //   try {
  //     print(id);
  //     print(token);
  //     // print(plateFormFile.path);
  //     Response response = await dio.post(
  //       '$baseUrl/api/assignments/$id/submissions',
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'multipart/form-data',
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('Upload successful');
  //       emit(HomeWorkSubmittedSuccess());
  //     } else {
  //       print('Upload failed: ${response.statusCode}');
  //       emit(HomeWorkSubmittedError('error'));
  //     }
  //   } catch (e) {
  //     print('Error during upload: $e');
  //     emit(HomeWorkSubmittedError('error'));
  //   }
  // }

  submitAssignment({
    required int id,
    required PlatformFile plateFormFile,
  }) async {
    emit(HomeWorkSubmittedLoading());
    Future.delayed(Duration(seconds: 2));
    String? token = await sharedPrefController.getToken();
    final uri = Uri.parse('$baseUrl/api/assignments/$id/submissions');

    var request = http.MultipartRequest('POST', uri);

    // Add file
    request.files.add(
      await http.MultipartFile.fromPath('assignment', plateFormFile.path!),
    );

    // Optional: Add headers (e.g., auth token)
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();
    // print(response.statusCode);
    // print('xxxxxxxxxxxxxxxx');
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print('Upload successful');
      emit(HomeWorkSubmittedSuccess());
    } else {
      // print('Upload failed: ${response.statusCode}');
      emit(HomeWorkSubmittedError('The file has not been uploaded successfully'));
    }

    //   Dio dio = Dio();
    //   String? token = await sharedPrefController.getToken();
    //   FormData formData = FormData.fromMap({
    //     'assignment ': await MultipartFile.fromFile(
    //       plateFormFile.path!,
    //       filename: plateFormFile.name,
    //     ),
    //   });

    //   try {
    //     print(id);
    //     print(token);
    //     // print(plateFormFile.path);
    //     Response response = await dio.post(
    //       '$baseUrl/api/assignments/$id/submissions',
    //       data: formData,
    //       options: Options(
    //         headers: {
    //           'Content-Type': 'multipart/form-data',
    //           'Accept': 'application/json',
    //           'Authorization': 'Bearer $token',
    //         },
    //       ),
    //     );

    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       print('Upload successful');
    //       emit(HomeWorkSubmittedSuccess());
    //     } else {
    //       print('Upload failed: ${response.statusCode}');
    //       emit(HomeWorkSubmittedError('error'));
    //     }
    //   } catch (e) {
    //     print('Error during upload: $e');
    //     emit(HomeWorkSubmittedError('error'));
    //   }
    // }
  }
}
