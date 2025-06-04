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
}
