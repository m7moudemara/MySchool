// Define the user types
enum UserType { student, teacher, parent }

// Common user interface
abstract class IUser {
  String get id;
  String get name;
  String get imageUrl;

  // Info displayed under the name (class, department, or children)
  String get displayInfo;

  // Attendance fields (nullable for non-students)
  int? get totalDays;
  int? get absentDays;

  // Should show attendance info?
  bool get showAttendance;

  // Helpful: get user type directly
  UserType get type;
}

// Student model
class Student implements IUser {
  @override
  final String id;

  @override
  final String name;

  @override
  final String imageUrl;

  final String className;

  @override
  String get displayInfo => className;

  @override
  final int totalDays;

  @override
  final int absentDays;

  @override
  bool get showAttendance => true;

  @override
  UserType get type => UserType.student;

  Student({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.className,
    required this.totalDays,
    required this.absentDays,
  });

  // Factory method to create from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
     id: json['id'] ?? '',
    name: json['name'] ?? '',
    imageUrl: json['imageUrl'] ?? 'https://example.com/default.jpg',
    className: json['className'] ?? 'Unknown Class',
    totalDays: json['totalDays'] ?? 0,
    absentDays: json['absentDays'] ?? 0,
    );
  }
}

// Teacher model
class Teacher implements IUser {
  @override
  final String id;

  @override
  final String name;

  @override
  final String imageUrl;

  final String department;

  @override
  String get displayInfo => department;

  @override
  final int? totalDays = null;

  @override
  final int? absentDays = null;

  @override
  bool get showAttendance => false;

  @override
  UserType get type => UserType.teacher;

  Teacher({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.department,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      department: json['department'] ?? "",
    );
  }
}

// Parent model
class Parent implements IUser {
  @override
  final String id;

  @override
  final String name;

  @override
  final String imageUrl;

  final String childrenInfo;

  @override
  String get displayInfo => childrenInfo;

  @override
  final int? totalDays = null;

  @override
  final int? absentDays = null;

  @override
  bool get showAttendance => false;

  @override
  UserType get type => UserType.parent;

  Parent({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.childrenInfo,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      childrenInfo: json['childrenInfo'] ?? '',
    );
  }
}
