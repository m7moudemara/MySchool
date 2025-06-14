import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources.dart';

import '../../../../../main.dart';
import '../../models/add_subjects_model.dart';

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final List<AddSubjectsModel> ubjects = [];

  @override
  // Future<List<AddSubjectsModel>> getAll() async => _subjects;
  Future<List<AddSubjectsModel>> getAll() async{
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
      List<AddSubjectsModel> resultx =
          result.map((element) => AddSubjectsModel.fromJson(element)).toList();
      return resultx;
    } else {
      throw Exception('error');
    }

  }

  @override
  Future<void> add(AddSubjectsModel newSubject) async {
    // _subjects.add(newSubject);
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

  }

  @override
  Future<void> update(AddSubjectsModel updatedSubject) async {
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
