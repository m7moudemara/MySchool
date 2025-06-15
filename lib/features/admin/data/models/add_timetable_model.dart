import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';

class AddTimeTableModel extends TimeTableEntity {
 const AddTimeTableModel({
    required super.id,
    required super.selectedClass,
    required super.selectedSubject,
    required super.selectedTeacher,
    required super.startTime,
    required super.day,
    required super.endTime, required super.selectedClassId, required super.selectedSubjectId, required super.selectedTeacherId,
  });

  factory AddTimeTableModel.fromEntity(TimeTableEntity entity) => AddTimeTableModel(
    id: entity.id.toString(),
    selectedClass: entity.selectedClass,
    selectedSubject: entity.selectedSubject,
    selectedTeacher: entity.selectedTeacher,
    startTime: entity.startTime,
    endTime: entity.endTime,
    selectedClassId: entity.selectedClassId,
    selectedSubjectId: entity.selectedSubjectId,
    selectedTeacherId: entity.selectedTeacherId,
    day: entity.day
  );
}
