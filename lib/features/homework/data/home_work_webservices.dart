import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class HomeWorkWebservices {
  // This class is responsible for handling web service calls related to homework.
  // It will contain methods to fetch, create, update, and delete homework assignments.

  // Example method to fetch homework assignments
  Future<List<Map<String, dynamic>>> fetchHomeworkAssignments() async {
    final url = Uri.parse(
      '$baseUrl/api/assignments?pageSize=500&Where[class.name]=B',
    ); // Replace with your API endpoint
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        jsonDecode(response.body)['data'],
      );
      return data;
      // Adjust based on your API response structure
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch homework assignments: ${response.statusCode}',
      );
    }
  }

  // Example method to create a new homework assignment
  Future<void> createHomeworkAssignment(
    Map<String, dynamic> assignmentData,
  ) async {
    // Here you would typically make an HTTP POST request to your backend API
    // with the assignment data.
  }

  // submitAssignment({
  //   required int id,
  //   required PlatformFile plateFormFile,
  // }) async {
  //   Dio dio = Dio();
  //   String? token = await sharedPrefController.getToken();
  //   FormData formData = FormData.fromMap({
  //     'assignment ': await MultipartFile.fromFile(
  //       plateFormFile.path!,
  //       filename: plateFormFile.name,
  //     ),
  //   });

  //   try {
  //     Response response = await dio.post(
  //       '$baseUrl/api/assignments/$id/submissions',
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('Upload successful');
  //       return true;
  //     } else {
  //       print('Upload failed: ${response.statusCode}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error during upload: $e');
  //     return false;
  //   }
  // }

  // Additional methods for updating and deleting assignments can be added here.

  Future<List<Map<String, dynamic>>> getSubmissions(int homeWorkId) async {
    final url = Uri.parse(
      '$baseUrl/api/assignments/$homeWorkId/submissions',
    ); // Replace with your API endpoint
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        jsonDecode(response.body)['data'],
      );
      return data;
      // Adjust based on your API response structure
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch homework assignments: ${response.statusCode}',
      );
    }
  }
}
