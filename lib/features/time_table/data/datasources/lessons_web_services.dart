import 'dart:convert';

import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;

class LessonsWebServices {
 Future getLessons() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/timetables');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      return result;
    } else {
      throw Exception('error');
    }
  }
}
