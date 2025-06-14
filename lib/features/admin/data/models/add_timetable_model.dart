import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';

class AddTimeTableModel extends TimeTableEntity {
 const AddTimeTableModel({
    required super.id,
    required super.selectedClass,
    required super.selectedSubject,
    required super.selectedTeacher,
    required super.startTime,
    required super.endTime,
  });

  factory AddTimeTableModel.fromEntity(TimeTableEntity entity) => AddTimeTableModel(
    id: entity.id,
    selectedClass: entity.selectedClass,
    selectedSubject: entity.selectedSubject,
    selectedTeacher: entity.selectedTeacher,
    startTime: entity.startTime,
    endTime: entity.endTime,
  );
}
