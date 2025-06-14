import '../../domain/entities/class_entity.dart';

class AddClassModel extends ClassEntity {
  AddClassModel({
    required super.id,
    required super.name,
    required super.subject,
    required super.studentsCount,
  });

  factory AddClassModel.fromJson(Map<String, dynamic> json) {
    return AddClassModel(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      studentsCount: json['studentsCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subject': subject,
    'studentsCount': studentsCount,
  };
}
