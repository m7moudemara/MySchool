import 'package:MySchool/features/school/domain/entities/user_type.dart';

class Teacher extends IUser {
  @override
  final int id;
  // final String id;
  @override
  final String name;
  @override
  final String imageUrl;
@override
  final bool isFirstLogin;
  final String department;

  @override
  String get displayInfo => department;
  @override
  final int? totalDays = null;
  @override
  final int? absentDays = null;


  @override
  UserType get type => UserType.teacher;

  Teacher( {
    required this.isFirstLogin,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.department,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      isFirstLogin : json['isFirstLogin'] ?? true,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      department: json['department'] ?? '',
    );
  }
}
