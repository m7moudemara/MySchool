import 'dart:convert';
import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/admin/data/data_sources/parent_data_sources/parent_local_data_sources.dart';
import 'package:MySchool/features/admin/data/models/add_parent_model.dart';
import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../main.dart';

class ParentLocalDataSourceImpl implements ParentLocalDataSource {
  @override
  Future<List<AddParentsModel>> getAll() async {
    final url = Uri.parse(
      '$baseUrl/api/accounts?Pagesize=500&Where%5Brole%5D=Guardian',
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
      List<AddParentsModel> resultx =
          result
              .map(
                (element) =>
                    AddParentsModel.fromEntity(ParentEntity.fromJson(element)),
              )
              .toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(AddParentsModel parent) async {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime date = inputFormat.parse(parent.dateOfBirth);

    // Format as yyyy-MM-dd
    String formatted = DateFormat('yyyy-MM-dd').format(date);
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
          "role": "Guardian",
          "user_name": parent.accountId,
          "password": parent.password,
          "national_id": parent.nationalId,
          "name": parent.fullName,
          "gender": parent.gender,
          "date_of_birth": formatted,
          "address": parent.address,
          "phone_number": parent.phoneNumber,
          "is_active": parent.isActive,
          "must_change_password": parent.mustChangePassword,
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
  Future<void> update(AddParentsModel updated) async {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    DateTime date = inputFormat.parse(updated.dateOfBirth);

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
        "role": "Guardian",
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
