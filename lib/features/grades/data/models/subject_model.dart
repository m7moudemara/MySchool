import 'package:MySchool/core/utils/grade_utils.dart';

class Subject {
  final String name;
  final int score;
  final String grade;

  Subject({
    required this.name,
    required this.score,
    required this.grade,

  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    final score = json['score'] as int;
    return Subject(
      name: json['subject'] as String,
      score: score,
      grade: getGrade(score),

    );
  }
}
