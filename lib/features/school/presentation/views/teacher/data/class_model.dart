
import '../../../../data/models/student_model.dart';

class ClassStudentModel {
  final int id;
  final int classId;
  final String name, className;
  final Student student;

  ClassStudentModel({
    required this.id,
    required this.name,
    required this.className,
    required this.classId,
    required this.student,
  });

  factory ClassStudentModel.fromJson(Map<String, dynamic> json) {
    return ClassStudentModel(
      id: json['student']['id'],
      name: json['student']['name'],
      className: json['class']['name'],
      classId: json['class']['id'],
      student: Student.fromJson(json['student']),
    );
  }
}
