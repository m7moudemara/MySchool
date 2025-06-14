import 'dart:convert';

import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_student_model.dart';
import 'package:http/http.dart' as http;

import '../../../../../constants/strings.dart';
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
  Future<void> add(AddStudentModel student) async => _students.add(student);

  @override
  Future<void> update(AddStudentModel updated) async {
    final index = _students.indexWhere((t) => t.id == updated.id);
    if (index != -1) _students[index] = updated;
  }

  @override
  Future<void> delete(String id) async {
    _students.removeWhere((t) => t.id == id);
  }
}
