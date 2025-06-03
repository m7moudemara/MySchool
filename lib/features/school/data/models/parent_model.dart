import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';

// This class represents a Parent model in a school management system.
class Parent extends IUser {
  @override
  final int id;
  // final String id;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final bool isFirstLogin;
  final String childrenInfo;
  final List<Student> children;
  final String className;
  final String user_name;
  @override
  final String date_of_birth;
  final String gender;
  final String address;
  @override
  final String phone;

  // The information about the children of the parent.
  @override
  String get displayInfo => childrenInfo;
  @override
  int? get totalDays => null;
  @override
  int? get absentDays => null;

  @override
  UserType get type => UserType.guardian;
  // UserType get type => UserType.parent;

  Parent(
    this.className,
    this.gender,
    this.address,
    this.phone,
    this.user_name,
    this.date_of_birth, {
    required this.isFirstLogin,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.childrenInfo,
    required this.children,
  });

  // Factory constructor to create a Parent instance from JSON data.
  factory Parent.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'];

    List<Student> childrenList = [];

    if (childrenJson != null && childrenJson is List) {
      childrenList = childrenJson.map((i) => Student.fromJson(i)).toList();
    }

    return Parent(
      json['className'] ?? '',
      json['gender'] ?? '',
      json['address'] ?? '',
      json['phone_number'] ?? '',
      json['user_name'] ?? '',
      json['date_of_birth'] ?? '',
      isFirstLogin: json['isFirstLogin'] ?? true,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      childrenInfo: json['total_students'] ?? '...\'s parent',
      children: childrenList,
    );
  }
}

class ParentDashboardUser implements DashboardUser {
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
  final int total_students;
  final double total;
  final double paid;
  final double remaining;

  ParentDashboardUser({
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
  });

  factory ParentDashboardUser.fromJson(Map<String, dynamic> json) {
    return ParentDashboardUser(
      id: json['account']['id'] ?? 0,
      name: json['account']['name'] ?? '',
      address: json['account']['address'] ?? '',
      date_of_birth: json['account']['date_of_birth'] ?? false,
      gender: json['account']['gender'] ?? '',
      last_active_time: json['account']['last_active_time'] ?? '',
      phone_number: json['account']['phone_number'] ?? '',
      total_notifications: json['account']['total_notifications'] ?? 0,
      total_students: json['total_students'] ?? 0,
      total: json['fee_info']['total'] ?? 0,
      paid: json['fee_info']['paid'] ?? 0,
      remaining: json['fee_info']['remaining'] ?? 0,
    );
  }
}
