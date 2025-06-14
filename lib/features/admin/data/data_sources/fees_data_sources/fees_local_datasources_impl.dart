import 'dart:convert';
import 'package:MySchool/features/admin/data/data_sources/fees_data_sources/fees_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_fees_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/strings.dart';
import '../../../../../main.dart';

class FeesLocalDataSourceImpl implements FeesLocalDataSource {
  final List<AddFeesModel> fees = [];

  @override
  // Future<List<AddFeesModel>> getAll() async => _fees;
  Future<List<AddFeesModel>> getAll() async {
    final url = Uri.parse('$baseUrl/api/fees?PageSize=500');
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
      List<AddFeesModel> resultx =
          result.map((element) => AddFeesModel.fromJson(element)).toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(AddFeesModel newFees) async {
    try {
      final url = Uri.parse('$baseUrl/api/fees');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          "student_id": newFees.selectSudentId,
          "total_amount": newFees.totalAmount,
          "paid_amount": newFees.paidAmount,
          "due_date": newFees.dueDate.toIso8601String(),
          "description": '',
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
  Future<void> update(AddFeesModel updatedFees) async {
    try {
      final url = Uri.parse('$baseUrl/api/fees/${updatedFees.id}');
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          "student_id": updatedFees.selectSudentId,
          "total_amount": updatedFees.totalAmount,
          "paid_amount": updatedFees.paidAmount,
          "due_date": updatedFees.dueDate.toIso8601String(),
          "description": '',
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
  Future<void> delete(String id) async {
    // _fees.removeWhere((c) => c.id == id);
    final url = Uri.parse('$baseUrl/api/fees/$id');
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
