import '../../domain/entities/class_entity.dart';

class AddClassModel extends ClassEntity {
  AddClassModel({
    required super.id,
    required super.name,
    required super.grade,
    required super.studentsCount,
  });

  factory AddClassModel.fromJson(Map<String, dynamic> json) {
    return AddClassModel(
      id: json['id'],
      name: json['name'],
      grade: json['grade'],
      studentsCount: json['studentsCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'grade': grade,
    'studentsCount': studentsCount,
  };
}