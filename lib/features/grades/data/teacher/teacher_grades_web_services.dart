import 'dart:convert';

import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;

class TeacherGradesWebServices {
  Future getStudentsGrades() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/grades?PageSize=500&IsList=true');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception();
    }
  }

  saveGrades(StudentResult studentResult) async {
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
