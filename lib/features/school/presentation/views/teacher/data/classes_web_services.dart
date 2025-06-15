import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../core/constants/strings.dart';
import '../../../../../../main.dart';

class ClassesWebServices {
  Future getClasses() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/enrollments');
    final response = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['data'];
      // print(result);
      return result;
    } else {
      throw Exception('error');
    }
  }

  Future getAttendance(int classId) async {
    String? token = await sharedPrefController.getToken();
    DateTime now = DateTime.now();
    try {
      final url = Uri.parse(
        '$baseUrl/api/attendances/class-attendance?ClassId=$classId&Date=${now.year}-${now.month}-${now.day}',
      );
      final response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'];
        // return response.data['data'];
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future saveAttendance(int studentId, int classId, String status) async {
    String? token = await sharedPrefController.getToken();
    DateTime now = DateTime.now();
    String dateStr = DateFormat('yyyy-MM-dd').format(now);

    try {
      final url = Uri.parse('$baseUrl/api/attendances');
      final response = await http.post(
        url,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "student_id": '$studentId',
          "class_id": '$classId',
          "date": dateStr,
          // "date": "${now.year}-${now.month}-${now.day}",
          "status": status,
          "note": "....",
          "leave_time": "12:30:00",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(jsonDecode(response.body));
        return jsonDecode(response.body);
        // return response.data['data'];
      } else {
        print('bbbbbbbbbb');
        print(response.statusCode);

        print('error ${jsonDecode(response.body)}');

        throw Exception('error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future updateAttendance(
    int studentId,
    int classId,
    String status,
    int attId,
  ) async {
    String? token = await sharedPrefController.getToken();
    DateTime now = DateTime.now();
    String dateStr = DateFormat('yyyy-MM-dd').format(now);
    try {
      final url = Uri.parse('$baseUrl/api/attendances/$attId');
      final response = await http.patch(
        url,
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "student_id": '$studentId',
          "class_id": '$classId',
          // "date": "2025-06-10",
          "date": dateStr,
          "status": status,
          "note": "....",
          "leave_time": "12:30:00",
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
        // return response.data['data'];
      } else {
        print('ffffffffffff');
        print(response.statusCode);

        print('error ${jsonDecode(response.body)}');

        throw Exception('error');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
