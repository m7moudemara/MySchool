import 'package:MySchool/core/utils/grade_utils.dart';

class SubjectGrade {
  final String name;
  final String mark;
  final String grade;
  final int termNumber;

  SubjectGrade({required this.name, required this.mark, required this.grade, required this.termNumber});

  factory SubjectGrade.fromJson(Map<String, dynamic> json) {
    return SubjectGrade(
      name: json['subject']['name'] as String,
      mark: json['mark'].toString(),
      grade: getGrade(json['mark'],100),
      termNumber: json['term_number']
      // grade: json['mark'] as String,
    );
  }
}
