import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../../constants/strings.dart';

class AttendenceStudentWebservices {
  // This class is responsible for handling web service calls related to student attendance.
  // It will contain methods to fetch, update, and manage attendance data for students.

  // Example method to fetch attendance data
  Future<List<Map<String, dynamic>>> fetchAttendanceData() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/attendances');
    final response = await http.get(
      url,
      headers: {
        'Authorization': ' Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print('qqqqqqqqqqqqqqqqqqqqq');
    if (response.statusCode == 200) {
      print('ppppppppppppppppppppp');
      // Parse the response body and return the attendance data
      List<Map<String, dynamic>> data = jsonDecode(response.body)['data'];
      print(data);
      print(data[0]);
      print(data[0]['id']);
      print('nnnnnnnnnnnnnnnnnnnn');
      // Handle the data as needed
      // print('Attendance data fetched successfully: $data');
      return data; // Return the parsed data
    } else {
      // Handle error response
      throw Exception(
        'Failed to fetch attendance data: ${response.statusCode}',
      );
    }
  }
}
