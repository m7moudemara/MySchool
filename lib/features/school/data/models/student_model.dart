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
  @override
  final String className;
  final String parentId;
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
  String get displayInfo => className;
  @override
  final int? totalDays;
  @override
  final int? absentDays;
  @override
  UserType get type => UserType.student;

  Student({
    required this.date_of_birth,
    required this.gender,
    required this.address,
    required this.phone,
    required this.user_name,
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
      date_of_birth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone_number'] ?? '',
      isFirstLogin: json['is_first_login'] ?? true,
      id: json['id'] ?? '',
      user_name: json['user_name'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      className: json['class_name'] ?? '',
      totalDays: json['total_attendance'] ?? 0,
      absentDays: json['absent_days'] ?? 0,
      parentId: json['parentId'] ?? '',
    );
  }
}

class StudentDashboardUser implements DashboardUser {
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
  final int total_notifications;
  @override
  final String className; // Placeholder for total notifications
  @override
  final int totalDays; // Placeholder for total days
  @override
  final int absentDays; // Placeholder for absent days
    @override
  final int total_students;
      @override
  final int total_classes;
  @override
  final double total;
  @override
  final double paid;
  @override
  final double remaining;




  StudentDashboardUser({
    required this.id,
    required this.name,
    required this.address,
    required this.date_of_birth,
    required this.gender,
    required this.last_active_time,
    required this.phone_number,
    required this.total_notifications,
    required this.className,
    required this.totalDays,
    required this.absentDays,
    required this.total_students,    required this.total,
    required this.paid,
    required this.remaining,
required this.total_classes
  });

  factory StudentDashboardUser.fromJson(Map<String, dynamic> json) {
    return StudentDashboardUser(
      id: json['account']['id'] ?? 0,
      name: json['account']['name'] ?? '',
      address: json['account']['address'] ?? '',
      date_of_birth: json['account']['date_of_birth'] ?? false,
      gender: json['account']['gender'] ?? '',
      last_active_time: json['account']['last_active_time'] ?? '',
      phone_number: json['account']['phone_number'] ?? '',
      total_notifications: json['account']['total_notifications'] ?? 0,
      className: json['class_name'] ?? '',
      totalDays: json['total_attendance'] ?? 0,
      absentDays: json['absent_days'] ?? 0,total_students: json['total_students']??0,      total: json['fee_info']['total'] ?? 0,
      paid: json['fee_info']['paid'] ?? 0,
      remaining: json['fee_info']['remaining'] ?? 0, total_classes: json['total_classes']??0,

    );
  }
}
