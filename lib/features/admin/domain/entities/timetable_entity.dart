class TimeTableEntity {
  final String id;
  final String selectedClass;
  final String selectedSubject;
  final String selectedTeacher;
  final int day;
  final int selectedClassId;
  final int selectedSubjectId;
  final int selectedTeacherId;
  final String startTime;
  final String endTime;

  const TimeTableEntity({
    required this.id,
    required this.selectedClass,
    required this.selectedSubject,
    required this.selectedTeacher,
    required this.startTime,
    required this.endTime,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedTeacherId,
    required this.day
  });

  factory TimeTableEntity.fromJson(Map<String, dynamic> json) {
    return TimeTableEntity(
      id: json['id'].toString(),
      selectedClass: json['class']['name'],
      selectedSubject: json['subject']['name'],
      selectedTeacher: json['teacher']['name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      selectedClassId: json['class']['id'],
      selectedSubjectId: json['subject']['id'],
      selectedTeacherId: json['teacher']['id'],
      day: json['day']
    );
  }
}
