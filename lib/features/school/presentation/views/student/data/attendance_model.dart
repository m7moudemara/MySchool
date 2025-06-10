// class AttendanceModel {
//   final int id;
//   final String date;
//   final String status;

//   AttendanceModel({required this.id, required this.date, required this.status});

//   factory AttendanceModel.fromJson(Map<String, dynamic> json) {
//     return AttendanceModel(
//       id: json['id'] ?? 0,
//       date: json['date'] ?? '',
//       status: json['status'] ?? 'Absent',
//     );
//   }
// }

import 'package:MySchool/features/school/data/models/student_model.dart';

class AttendanceModel {
  int id;
  int classId;
  String name;
  String date;
  String status;

  AttendanceModel({
    required this.id,
    required this.date,
    required this.status,
    required this.name,
    required this.classId,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? 'Absent',
      name: json['student']['name'],
      classId: json['class']['id'],
    );
  }
}

class TeacherAttendanceForStudent {
  Student student;
  AttendanceModel? attendanceModel;

  TeacherAttendanceForStudent({
    required this.student,
    required this.attendanceModel,
  });

  factory TeacherAttendanceForStudent.fromJson(Map<String, dynamic> json) {
    return TeacherAttendanceForStudent(
      student: Student.fromJson(json['student']),
      attendanceModel:
          json['attendance'] == null
              ? null
              : AttendanceModel.fromJson(json['attendance']),
    );
  }

  TeacherAttendanceForStudent copy() {
    return TeacherAttendanceForStudent(
      student: student,
      attendanceModel:
          attendanceModel
      // copy other properties
    );
  }
}
