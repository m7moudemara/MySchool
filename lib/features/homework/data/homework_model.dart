class HomeworkModel {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool is_deadline_passed ;

  HomeworkModel( {required this.is_deadline_passed,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  // Factory method to create a HomeworkModel from a map
  factory HomeworkModel.fromJson(Map<String, dynamic> map) {
    return HomeworkModel(
      is_deadline_passed: map['is_deadline_passed'] as bool,
      id: map['id'] as int,
      title: map['subject']['name'] as String,
      description: map['subject']['description'] as String,
      dueDate: DateTime.parse(map['deadline'] as String),
    );
  }

  // Method to convert HomeworkModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
