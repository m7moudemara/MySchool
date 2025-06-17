import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_timetable_model.dart';
import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/add_timetable_repository.dart';

class AddTimeTableRepositoryImpl implements AddTimeTableRepository {
  final AddTimeTableLocalDataSource localDataSource;
  AddTimeTableRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTimeTable(TimeTableEntity newTimeTable) {
    return localDataSource.add(
      AddTimeTableModel(
        id: newTimeTable.id,
        selectedClass: newTimeTable.selectedClass,
        selectedSubject: newTimeTable.selectedSubject,
        selectedTeacher: newTimeTable.selectedTeacher,
        startTime: newTimeTable.startTime,
        endTime: newTimeTable.endTime,
        selectedClassId: newTimeTable.selectedClassId,
        selectedSubjectId: newTimeTable.selectedSubjectId,
        selectedTeacherId: newTimeTable.selectedTeacherId,
        day: newTimeTable.day,
      ),
    );
  }

  @override
  Future<void> deleteTimeTable(String id) {
    return localDataSource.delete(id);
  }

  @override
  Future<List<TimeTableEntity>> getAllTimeTables() {
    return localDataSource.getAll();
  }

  @override
  Future<void> updateTimeTable(TimeTableEntity updatedTimeTable) {
    return localDataSource.update(
      AddTimeTableModel(
        id: updatedTimeTable.id,
        selectedClass: updatedTimeTable.selectedClass,
        selectedSubject: updatedTimeTable.selectedSubject,
        selectedTeacher: updatedTimeTable.selectedTeacher,
        startTime: updatedTimeTable.startTime,
        endTime: updatedTimeTable.endTime,
        selectedClassId: updatedTimeTable.selectedClassId,
        selectedSubjectId: updatedTimeTable.selectedSubjectId,
        selectedTeacherId: updatedTimeTable.selectedTeacherId,
        day: updatedTimeTable.day,
      ),
    );
  }
}
