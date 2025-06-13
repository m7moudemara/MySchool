import 'dart:convert';
import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/main.dart';
import '../../models/class_model.dart';
import 'class_local_datasource.dart';
import 'package:http/http.dart' as http;

class ClassLocalDataSourceImpl implements ClassLocalDataSource {
  final List<ClassModel> _classes = [];

  @override
  // Future<List<ClassModel>> getAll() async => _classes;
  Future<List<ClassModel>> getAll() async {
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
      List<ClassModel> classesModeled =
          classes.map((element) => ClassModel.fromJson(element)).toList();
      return classesModeled;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(ClassModel newClass) async {
    _classes.add(newClass);
  }

  @override
  Future<void> update(ClassModel updatedClass) async {
    final index = _classes.indexWhere((c) => c.id == updatedClass.id);
    if (index != -1) {
      _classes[index] = updatedClass;
    }
  }

  @override
  Future<void> delete(String id) async {
    _classes.removeWhere((c) => c.id == id);
  }
}
