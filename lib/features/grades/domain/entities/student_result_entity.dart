import 'package:MySchool/features/grades/domain/entities/sub_entity/subject_grade.dart';

class StudentResultEntity {
  final String studentName;
  final String className;
  final String imageUrl;
  final List<SubjectGrade> subjects;
  final String totalMarks;
  final String overallPercentage;
  final String overallGrade;

  StudentResultEntity({
    required this.studentName,
    required this.className,
    required this.imageUrl,
    required this.subjects,
    required this.totalMarks,
    required this.overallPercentage,
    required this.overallGrade,
  });

  factory StudentResultEntity.fromJson(Map<String, dynamic> json) {
    return StudentResultEntity(
      studentName: json['studentName'] as String,
      className: json['className'] as String,
      imageUrl: json['imageUrl'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalMarks: json['totalMarks'] as String,
      overallPercentage: json['overallPercentage'] as String,
      overallGrade: json['overallGrade'] as String,
    );
  }
}
