import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_student_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../../main.dart';
import '../../../domain/entities/student_entity.dart';

class StudentLocalDataSourceImpl implements StudentLocalDataSource {
  final List<AddStudentModel> _students = [];

  @override
  // Future<List<AddStudentModel>> getAll() async => _students;
  Future<List<AddStudentModel>> getAll() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Student',
    );
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      List<AddStudentModel> resultx =
          result
              .map(
                (element) =>
                    AddStudentModel.fromEntity(StudentEntity.fromJson(element)),
              )
              .toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  // Future<void> add(AddStudentModel student) async => _students.add(student);
  Future<void> add(AddStudentModel student) async {
    //     print(parent.accountId);
    // print('##########');
    // print(parent.accountId);
    // print(parent.password);
    // print(parent.nationalId);
    // print(parent.fullName);
    // print(parent.gender);
    // print(parent.dateOfBirth);
    // print(parent.address);
    // print(parent.phoneNumber);
    // print(parent.isActive);
    // print(parent.mustChangePassword);

    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime date = inputFormat.parse(student.dateOfBirth);

    // Format as yyyy-MM-dd
    String formatted = DateFormat('yyyy-MM-dd').format(date);
    print(formatted);
    print('##################');
    try {
      final url = Uri.parse('$baseUrl/api/accounts');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          "role": "Student",
          "user_name": student.accountId,
          "password": student.password,
          "national_id": student.nationalId,
          "name": student.fullName,
          "gender": student.gender,
          "date_of_birth": formatted,
          "address": student.address,
          "phone_number": student.phoneNumber,
          "is_active": student.isActive,
          "must_change_password": student.mustChangePassword,
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> update(AddStudentModel updated) async {
    // final index = _students.indexWhere((t) => t.id == updated.id);
    // if (index != -1) _students[index] = updated;
    // final index = _parents.indexWhere((t) => t.id == updated.id);
    // if (index != -1) _parents[index] = updated;
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    // DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime date = inputFormat.parse(updated.dateOfBirth);

    // Format as yyyy-MM-dd
    String formatted = DateFormat('yyyy-MM-dd').format(date);
    print(formatted);

    final url = Uri.parse('$baseUrl/api/accounts/${updated.id}');
    await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "role": "Student",
        "user_name": updated.accountId,
        "password": updated.password,
        "national_id": updated.nationalId,
        "name": updated.fullName,
        "gender": updated.gender,
        "date_of_birth": formatted,
        "address": updated.address,
        "phone_number": updated.phoneNumber,
        "is_active": updated.isActive,
        "must_change_password": updated.mustChangePassword,
      }),
    );
  }

  @override
  Future<void> delete(String id) async {
    // _students.removeWhere((t) => t.id == id);
    final url = Uri.parse('$baseUrl/api/accounts/$id');
    await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
  }
}
