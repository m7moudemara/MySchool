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
  final String className;
  @override
  final String user_name;
  @override
  final String date_of_birth;
  @override
  final String gender;
  @override
  final String address;
  @override
  final String phone;
  @override
  String get displayInfo => department;
  @override
  final int? totalDays = null;
  @override
  final int? absentDays = null;

  @override
  UserType get type => UserType.teacher;

  Teacher(
    this.className,
    this.user_name,
    this.date_of_birth,
    this.gender,
    this.address,
    this.phone, {
    required this.isFirstLogin,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.department,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      json['className'] ?? '',
      json['user_name'] ?? '',
      json['date_of_birth'] ?? '',
      json['gender'] ?? '',
      json['address'] ?? '',
      json['phone_number'] ?? '',
      isFirstLogin: json['isFirstLogin'] ?? true,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      department: json['department'] ?? '',
    );
  }
}

class TeacherDashboardUser implements DashboardUser {
  @override
  final int id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String date_of_birth;
  @override
  final String gender;
  @override
  final String last_active_time;
  @override
  final String phone_number;
  @override
  final int total_notifications; // Placeholder for total notifications
  @override
  String get className => ''; // Teachers may not have a class name
  @override
  final int totalDays = 0; // Placeholder for total days
  @override
  final int absentDays = 0; // Placeholder for absent days
  @override
  final int total_students;
  @override
  final double total;
  @override
  final double paid;
  @override
  final double remaining;
  @override
  final int total_classes;
  TeacherDashboardUser({
    required this.id,
    required this.name,
    required this.address,
    required this.date_of_birth,
    required this.gender,
    required this.last_active_time,
    required this.phone_number,
    required this.total_notifications,
    required this.total_students,
    required this.total,
    required this.paid,
    required this.remaining,
    required this.total_classes,
  });

  factory TeacherDashboardUser.fromJson(Map<String, dynamic> json) {
    return TeacherDashboardUser(
      id: json['account']['id'] ?? 0,
      name: json['account']['name'] ?? '',
      address: json['account']['address'] ?? '',
      date_of_birth: json['account']['date_of_birth'] ?? false,
      gender: json['account']['gender'] ?? '',
      last_active_time: json['account']['last_active_time'] ?? '',
      phone_number: json['account']['phone_number'] ?? '',
      total_notifications: json['account']['total_notifications'] ?? 0,
      total_students: json['total_students'] ?? 0,
      total: 0,
      paid: 0,
      remaining: 0,
      total_classes: json['total_classes'] ?? 0,
    );
  }
}
