class ClassStudentModel {
  final int id;
  final int classId;
  final String name, className;

  ClassStudentModel({
    required this.id,
    required this.name,
    required this.className,
    required this.classId,
  });

  factory ClassStudentModel.fromJson(Map<String, dynamic> json) {
    return ClassStudentModel(
      id: json['student']['id'],
      name: json['student']['name'],
      className: json['class']['name'],
      classId: json['class']['id'],
    );
  }
}
