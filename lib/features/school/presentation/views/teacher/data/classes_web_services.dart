import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../constants/strings.dart';
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
      return result;
    } else {
      throw Exception('error');
    }
  }
}
