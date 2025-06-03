class AttendanceModel {
  final int id;
  final String date;
  final String status;

  AttendanceModel({required this.id, required this.date, required this.status});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? 'Absent',
    );
  }
}
