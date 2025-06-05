class TeacherClassModel {
  final int id, grade, student_count;
  final String name;

  TeacherClassModel({
    required this.id,
    required this.grade,
    required this.student_count,
    required this.name,
  });

  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassModel(
      id: json['id'],
      grade: json['grade'],
      student_count: json['student_count'],
      name: json['name'],
    );
  }
}
