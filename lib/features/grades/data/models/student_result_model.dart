import 'package:MySchool/features/grades/data/models/sub_model/subject_model.dart';
import 'package:MySchool/features/grades/domain/entities/student_result_entity.dart';

class StudentResultModel extends StudentResultEntity {
  StudentResultModel({
    required super.studentName,
    required super.className,
    required super.imageUrl,
    required super.subjects,
    required super.totalMarks,
    required super.overallPercentage,
    required super.overallGrade,
  });

  factory StudentResultModel.fromJson(Map<String, dynamic> json) {
    return StudentResultModel(
      studentName: json['student_name'],
      className: json['class_name'],
      imageUrl: json['image_url'],
      totalMarks: json['total_marks'],
      overallPercentage: json['overall_percentage'],
      overallGrade: json['overall_grade'],
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => SubjectGradeModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'class_name': className,
      'image_url': imageUrl,
      'total_marks': totalMarks,
      'overall_percentage': overallPercentage,
      'overall_grade': overallGrade,
      'subjects': subjects.map((e) => (e as SubjectGradeModel).toJson()).toList(),
    };
  }
}
