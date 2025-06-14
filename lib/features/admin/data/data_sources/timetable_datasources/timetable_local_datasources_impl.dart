

import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_timetable_model.dart';

class AddTimeTableLocalDataSourceImpl implements AddTimeTableLocalDataSource {
  final List<AddTimeTableModel> _timeTables = [];

  @override
  Future<List<AddTimeTableModel>> getAll() async => _timeTables;

  @override
  Future<void> add(AddTimeTableModel timeTable) async => _timeTables.add(timeTable);

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
