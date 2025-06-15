import 'dart:convert';


import 'package:MySchool/core/constants/strings.dart';

import '../../../../../main.dart';
import '../../models/add_class_model.dart';
import 'class_local_datasource.dart';
import 'package:http/http.dart' as http;

class ClassLocalDataSourceImpl implements ClassLocalDataSource {
  final List<AddClassModel> classes = [];

  @override
  // Future<List<AddClassModel>> getAll() async => _classes;
  Future<List<AddClassModel>> getAll() async {
    final url = Uri.parse('$baseUrl/api/classes');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      List classes = jsonDecode(response.body)['data'];
      List<AddClassModel> classesModeled =
          classes.map((element) => AddClassModel.fromJson(element)).toList();
      return classesModeled;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(AddClassModel newClass) async {
    // _classes.add(newClass);
    final url = Uri.parse('$baseUrl/api/classes');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'name': newClass.name,
        'grade': int.parse(newClass.grade.replaceAll("Grade ", "")),
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Map<String, dynamic> result = jsonDecode(response.body);
      // print(result);
      // AddClassModel resultX = AddClassModel.fromJson(result);
      // _classes.add(resultX);
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> update(AddClassModel updatedClass) async {
    // final index = _classes.indexWhere((c) => c.id == updatedClass.id);
    // if (index != -1) {
    //   _classes[index] = updatedClass;
    // }

    try {
      final url = Uri.parse('$baseUrl/api/classes/${updatedClass.id}');
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'name': updatedClass.name,
          'grade': int.parse(updatedClass.grade.replaceAll("Grade ", "")),
        }),
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
    // _classes.removeWhere((c) => c.id == id);
    final url = Uri.parse('$baseUrl/api/classes/$id');
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
