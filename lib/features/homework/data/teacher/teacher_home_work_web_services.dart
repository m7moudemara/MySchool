import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../constants/strings.dart';
import '../../../../main.dart';

class TeacherHomeWorkWebServices {
    Future<List<Map<String, dynamic>>> fetchTeacherClasses() async {
    final url = Uri.parse(
      '$baseUrl/api/classes',
    ); 
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
      // Parse the response body and return the homework assignments
      return data;
      // Adjust based on your API response structure
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch homework assignments: ${response.statusCode}',
      );
    }
  }

      Future<List<Map<String, dynamic>>> fetchTeacherSubjects() async {
    final url = Uri.parse(
      '$baseUrl/api/subjects',
    ); 
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
      // Parse the response body and return the homework assignments
      return data;
      // Adjust based on your API response structure
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch homework assignments: ${response.statusCode}',
      );
    }
  }

        Future<List<Map<String, dynamic>>> fetchTeacherHomeWorks() async {
    final url = Uri.parse(
      '$baseUrl/api/assignments',
    ); 
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
      // Parse the response body and return the homework assignments
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