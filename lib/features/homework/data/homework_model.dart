class HomeworkModel {
  final int id;
  final int class_id;
  final int Subject_id;
  final String title;
  final String subject_name;
  final String description;
  final String dueDate;
  final bool is_deadline_passed;
  final String file_path;
  final DateTime deadline;

  HomeworkModel({
    required this.id,
    required this.class_id,
    required this.Subject_id,
    required this.subject_name,
    required this.description,
    required this.dueDate,
    required this.is_deadline_passed,
    required this.file_path,
    required this.deadline,
    required this.title,
  });

  // Factory method to create a HomeworkModel from a map
  factory HomeworkModel.fromJson(Map<String, dynamic> map) {
    return HomeworkModel(
      id: map['id'] as int,
      class_id: map['class']['id'] ?? 0,
      Subject_id: map['subject']['id'] ?? 0,
      title: map['title'] as String,
      subject_name: map['subject']['name'] as String,
      description: map['subject']['description'] as String,
      dueDate: map['deadline'] ?? '',
      is_deadline_passed: map['is_deadline_passed'] as bool,
      file_path: map['file_path'] ?? '',
      deadline: DateTime.parse(map['deadline'] ?? DateTime.now()),
    );
  }

  // Method to convert HomeworkModel to a map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'dueDate': dueDate.toIso8601String(),
  //   };
  // }
}
