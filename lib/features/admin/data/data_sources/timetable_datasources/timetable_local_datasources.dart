import 'package:MySchool/features/admin/data/models/add_timetable_model.dart';

abstract class AddTimeTableLocalDataSource {
  Future<List<AddTimeTableModel>> getAll();
  Future<void> add(AddTimeTableModel timeTable);
  Future<void> update(AddTimeTableModel timeTable);
  Future<void> delete(String id);
}
