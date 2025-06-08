class SubjectGrade {
  final String name;
  final String mark;
  final String grade;

  SubjectGrade({
    required this.name,
    required this.mark,
    required this.grade,
  });

  factory SubjectGrade.fromJson(Map<String, dynamic> json){
    return SubjectGrade(
      name: json['name'] as String,
      mark: json['mark'] as String,
      grade: json['grade'] as String,
    );
  }
}
