import 'dart:convert';

import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';
import 'package:MySchool/features/admin/domain/entities/teacher_entity.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/strings.dart';
import '../../../../../main.dart';

abstract class TeacherLocalDataSource {
  Future<List<AddTeachersModel>> getAll();
  Future<void> add(AddTeachersModel teacher);
  Future<void> update(AddTeachersModel teacher);
  Future<void> delete(String id);
}

// implementation
class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
  final List<AddTeachersModel> _teachers = [];

  @override
  // Future<List<AddTeachersModel>> getAll() async => _teachers;
  Future<List<AddTeachersModel>> getAll() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Teacher',
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
      List<AddTeachersModel> resultx =
          result
              .map(
                (element) => AddTeachersModel.fromEntity(
                  TeacherEntity.fromJson(element),
                ),
              )
              .toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  // Future<void> add(AddTeachersModel teacher) async => _teachers.add(teacher);
  Future<void> add(AddTeachersModel teacher) async {
    final url = Uri.parse('$baseUrl/api/accounts');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "role": "Teacher",
        "user_name": teacher.accountId,
        "password": teacher.password,
        "national_id": teacher.nationalId,
        "name": teacher.fullName,
        "gender": teacher.gender,
        "date_of_birth": teacher.dateOfBirth,
        "address": teacher.address,
        "phone_number": teacher.phoneNumber,
        "is_active": teacher.isActive,
        "must_change_password": teacher.mustChangePassword,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> update(AddTeachersModel updated) async {
    // final index = _teachers.indexWhere((t) => t.id == updated.id);
    // if (index != -1) _teachers[index] = updated;
    final url = Uri.parse('$baseUrl/api/accounts/${updated.id}');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "role": "Teacher",
        "user_name": updated.accountId,
        "password": updated.password,
        "national_id": updated.nationalId,
        "name": updated.fullName,
        "gender": updated.gender,
        "date_of_birth": updated.dateOfBirth,
        "address": updated.address,
        "phone_number": updated.phoneNumber,
        "is_active": updated.isActive,
        "must_change_password": updated.mustChangePassword,
      }),
    );
    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   throw Exception('error');
    // }
  }

  @override
  Future<void> delete(String id) async {
    // _teachers.removeWhere((t) => t.id == id);
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
