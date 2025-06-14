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

  factory TimeTableEntity.fromJson(Map<String, dynamic> json) {
    return TimeTableEntity(
      id: json['id'].toString(),
      selectedClass: json['class']['name'],
      selectedSubject: json['subject']['name'],
      selectedTeacher: json['teacher']['name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
