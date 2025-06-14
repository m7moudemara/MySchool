import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';

class AddSubjectsModel extends SubjectEntity {
  AddSubjectsModel({required super.id, required super.name});

  factory AddSubjectsModel.fromJson(Map<String, dynamic> json) {
    return AddSubjectsModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
