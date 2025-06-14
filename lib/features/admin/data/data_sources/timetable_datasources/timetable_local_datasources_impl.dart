import 'dart:convert';

import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_timetable_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/strings.dart';
import '../../../../../main.dart';
import '../../../domain/entities/timetable_entity.dart';

class AddTimeTableLocalDataSourceImpl implements AddTimeTableLocalDataSource {
  final List<AddTimeTableModel> _timeTables = [];

  @override
  // Future<List<AddTimeTableModel>> getAll() async => _timeTables;
  Future<List<AddTimeTableModel>> getAll() async {
    final url = Uri.parse('$baseUrl/api/timetables?PageSize=500');
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
      List<AddTimeTableModel> resultx =
          result
              .map(
                (element) => AddTimeTableModel.fromEntity(
                  TimeTableEntity.fromJson(element),
                ),
              )
              .toList();
      return resultx;
    } else {
      throw Exception('error');
    }
  }

  @override
  Future<void> add(AddTimeTableModel timeTable) async =>
      _timeTables.add(timeTable);

  @override
  Future<void> update(AddTimeTableModel updated) async {
    final index = _timeTables.indexWhere((t) => t.id == updated.id);
    if (index != -1) _timeTables[index] = updated;
  }

  @override
  Future<void> delete(String id) async {
    _timeTables.removeWhere((t) => t.id == id);
  }
}
