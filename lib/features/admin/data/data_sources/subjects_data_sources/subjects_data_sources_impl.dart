import 'dart:convert';

import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources.dart';
import 'package:MySchool/features/admin/data/models/subjects.dart';
import 'package:http/http.dart' as http;
import '../../../../../main.dart';

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final List<Subjects> _subjects = [];

  @override
  // Future<List<Subjects>> getAll() async => _subjects;
  Future<List<Subjects>> getAll() async {
    final url = Uri.parse('$baseUrl/api/subjects');
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
      List<Subjects> resultx =
          result.map((element) => Subjects.fromJson(element)).toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(Subjects newSubject) async {
    final url = Uri.parse('$baseUrl/api/subjects');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({'name': newSubject.name}),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('error');
    }
    // _subjects.add(newSubject);
  }

  @override
  Future<void> update(Subjects updatedSubject) async {
    // final index = _subjects.indexWhere((c) => c.id == updatedSubject.id);
    // if (index != -1) {
    //   _subjects[index] = updatedSubject;
    // }
    try {
      final url = Uri.parse('$baseUrl/api/subjects/${updatedSubject.id}');
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({'name': updatedSubject.name}),
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> delete(String id) async {
    // _subjects.removeWhere((c) => c.id == id);
    final url = Uri.parse('$baseUrl/api/subjects/$id');
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
