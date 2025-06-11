import 'package:MySchool/features/school/domain/entities/user_type.dart';

class Admin extends IUser {
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
  // final List<Student> children;
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

  Admin({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isFirstLogin,
    required this.childrenInfo,
    required this.className,
    required this.user_name,
    required this.date_of_birth,
    required this.gender,
    required this.address,
    required this.phone,
  });

  // The information about the children of the parent.
  @override
  String get displayInfo => childrenInfo;
  @override
  int? get totalDays => null;
  @override
  int? get absentDays => null;

  @override
  UserType get type => UserType.guardian;

  factory Admin.fromJson(Map<String, dynamic> json) {
    // final childrenJson = json['children'];

    // List<Student> childrenList = [];

    // if (childrenJson != null && childrenJson is List) {
    //   childrenList = childrenJson.map((i) => Student.fromJson(i)).toList();
    // }

    return Admin(
      isFirstLogin: json['isFirstLogin'] ?? true,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      childrenInfo: json['total_students'] ?? '...\'s parent',
      className: json['className'] ?? '',
      user_name: json['user_name'] ?? '',
      date_of_birth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone_number'] ?? '',
    );
  }
}

class AdminDashboardUser implements DashboardUser {
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
  final int total_teachers;
  final int total_classes;
  final int total_subjects;
  final int total_timetables;
  // final int total_notifications_admin; // Renamed to avoid duplicate
  final double total_fees_collected;
  final double total_fees_remaining;
  final int total_assignments_created;
  final int total_assignments_submitted;
  final int total_attendance;
  final int total_attendance_absent;
  final int total_attendance_present;

  AdminDashboardUser({
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
    required this.total_teachers,
    required this.total_classes,
    required this.total_subjects,
    required this.total_timetables,
    // required this.total_notifications_admin,
    required this.total_fees_collected,
    required this.total_fees_remaining,
    required this.total_assignments_created,
    required this.total_assignments_submitted,
    required this.total_attendance,
    required this.total_attendance_absent,
    required this.total_attendance_present,
  });

  factory AdminDashboardUser.fromJson(Map<String, dynamic> json) {
    return AdminDashboardUser(
      id: 0,
      name: '',
      address: '',
      date_of_birth: '',
      gender: '',
      last_active_time: '',
      phone_number: '',
      // total_notifications: 0,
      total_students: 0,
      total: 0,
      paid: 0,
      remaining: 0,
      total_teachers: json['total_teachers'] ?? 0,
      total_classes: json['total_classes'] ?? 0,
      total_subjects: json['total_subjects'] ?? 0,
      total_timetables: json['total_timetables'] ?? 0,
      total_notifications: json['total_notifications_admin'] ?? 0,
      total_fees_collected: json['total_fees_collected'] ?? 0,
      total_fees_remaining: json['total_fees_remaining'] ?? 0,
      total_assignments_created: json['total_assignments_created'] ?? 0,
      total_assignments_submitted: json['total_assignments_submitted'] ?? 0,
      total_attendance: json['total_attendance'] ?? 0,
      total_attendance_absent: json['total_attendance_absent'] ?? 0,
      total_attendance_present: json['total_attendance_present'] ?? 0,
    );
  }
}
