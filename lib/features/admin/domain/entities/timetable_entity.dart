class TimeTableEntity {
  final String id;
  final String selectedClass;
  final String selectedSubject;
  final String selectedTeacher;
  final String startTime;
  final String endTime;

  const TimeTableEntity({
    required this.id,
    required this.selectedClass,
    required this.selectedSubject,
    required this.selectedTeacher,
    required this.startTime,
    required this.endTime,
  });
}
