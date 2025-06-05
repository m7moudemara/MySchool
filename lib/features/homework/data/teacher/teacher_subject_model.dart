class TeacherSubjectModel {
  final int id;
  final String name, description;

  TeacherSubjectModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) {
    return TeacherSubjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
