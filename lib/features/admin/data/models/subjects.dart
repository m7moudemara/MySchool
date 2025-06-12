import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';

class Subjects extends SubjectEntity {
  Subjects({required super.id, required super.name});

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
