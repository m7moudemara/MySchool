
import 'package:MySchool/features/grades/domain/entities/sub_entity/subject_grade.dart';

class SubjectGradeModel extends SubjectGrade {
  SubjectGradeModel({
    required super.name,
    required super.mark,
    required super.grade,
    required super.termNumber,
  });

  factory SubjectGradeModel.fromJson(Map<String, dynamic> json) {
    return SubjectGradeModel(
      name: json['name'],
      mark: json['mark'],
      grade: json['grade'],
      termNumber: json['termNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mark': mark,
      'grade': grade,
    };
  }
}
