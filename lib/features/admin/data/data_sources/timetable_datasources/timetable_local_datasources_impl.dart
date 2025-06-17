import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_timetable_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../main.dart';
import '../../../domain/entities/timetable_entity.dart';

class AddTimeTableLocalDataSourceImpl implements AddTimeTableLocalDataSource {
  @override
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
  Future<void> add(AddTimeTableModel timeTable) async {
    DateFormat inputFormat = DateFormat('h:mm a');
    DateFormat outputFormat = DateFormat('HH:mm:ss');

    DateTime dateTimeStart = inputFormat.parse(timeTable.startTime);
    DateTime dateTimeEnd = inputFormat.parse(timeTable.endTime);

    String start = outputFormat.format(dateTimeStart);
    String end = outputFormat.format(dateTimeEnd);
    print(start);
    print(end);
    try {
      final url = Uri.parse('$baseUrl/api/timetables');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          "class_id": timeTable.selectedClassId,
          "subject_id": timeTable.selectedSubjectId,
          "teacher_id": timeTable.selectedTeacherId,
          "day": 1,
          "start_time": start.toString(),
          "end_time": end.toString(),
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
  Future<void> update(AddTimeTableModel updated) async {
    DateFormat inputFormat = DateFormat('h:mm a');
    DateFormat outputFormat = DateFormat('HH:mm:ss');

    DateTime dateTimeStart = inputFormat.parse(updated.startTime);
    DateTime dateTimeEnd = inputFormat.parse(updated.endTime);

    String start = outputFormat.format(dateTimeStart);
    String end = outputFormat.format(dateTimeEnd);

    final url = Uri.parse('$baseUrl/api/timetables/${updated.id}');
    await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
        'Accept': 'application/json',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "class_id": updated.selectedClassId,
        "subject_id": updated.selectedSubjectId,
        "teacher_id": updated.selectedTeacherId,
        "day": 1,
        "start_time": start.toString(),
        "end_time": end.toString(),
      }),
    );
  }

  @override
  Future<void> delete(String id) async {
    final url = Uri.parse('$baseUrl/api/timetables/$id');
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
