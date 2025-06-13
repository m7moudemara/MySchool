import '../../domain/entities/class_entity.dart';

class ClassModel extends ClassEntity {
  ClassModel({
    required super.id,
    required super.name,
    required super.grade,
    required super.studentsCount,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'].toString(),
      name: json['name'],
      grade: json['grade'].toString(),
      studentsCount: json['student_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'grade': grade,
    'studentsCount': studentsCount,
  };
}
