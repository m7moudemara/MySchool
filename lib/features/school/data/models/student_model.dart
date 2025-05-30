import 'package:MySchool/features/school/domain/entities/user_type.dart';

class Student extends IUser {
  @override
  final int id;
  // final String id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final bool isFirstLogin;

  final String className;
  final String parentId;

  @override
  String get displayInfo => className;
  @override
  final int? totalDays;
  @override
  final int? absentDays;
  @override
  UserType get type => UserType.student;

  Student( {
    required this.isFirstLogin,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.className,
    required this.totalDays,
    required this.absentDays,
    required this.parentId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      isFirstLogin : json['is_first_login'] ?? true,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      className: json['className'] ?? '',
      totalDays: json['totalDays'] ?? 0,
      absentDays: json['absentDays'] ?? 0,
      parentId: json['parentId'] ?? '',
    );
  }
}
