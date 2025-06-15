import 'dart:convert';
import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;

class TeacherGradesWebServices {
  Future<List<Map<String, dynamic>>> fetchTeacherSubjects() async {
    final url = Uri.parse('$baseUrl/api/subjects');
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
    } else {
      throw Exception(
        'Failed to fetch homework assignments: ${response.statusCode}',
      );
    }
  }

  Future<List<Map<String, dynamic>>> getStudentsGrades(int subjectId, int term) async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse(
      '$baseUrl/api/grades/subject-grades?SubjectId=$subjectId&Term=$term&PageSize=500',
    );

    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
            List<Map<String, dynamic>> grades = List<Map<String, dynamic>>.from(
        jsonDecode(response.body)['data'],
      );

      // var data = jsonDecode(response.body)['data'];
      // print(jsonDecode(response.body)['data']);
      // print('xoxoxoxoxox');
      return grades;
      // print({"subjects": datax, "grades": data});
    } else {
      throw Exception();
    }
  }

  saveGrades(StudentResult studentResult) async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/grades');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "student_id": studentResult.studentId.toString(),
          "subject_id": studentResult.subjectId.toString(),
          "term_number": studentResult.term.toString(),
          "mark": studentResult.grade.toString(),
        }),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print(e);
    }
  }



  updateGrades(StudentResult studentResult) async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/grades/${studentResult.id}');
    try {
      final response = await http.patch(
        url,
        body: jsonEncode({
          "student_id": studentResult.studentId.toString(),
          "subject_id": studentResult.subjectId.toString(),
          "term_number": studentResult.term.toString(),
          "mark": studentResult.grade.toString(),
        }),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print(e);
    }
  }
}
