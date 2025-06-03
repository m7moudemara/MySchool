// This file defines an enum for user types in a school management system.
enum UserType { student, teacher, guardian }
// enum UserType { student, teacher, parent }

// This file defines an interface for user entities in a school management system.
abstract class IUser {
  int get id;
  // String get id;
  String get name;
  String get className;
  String get user_name;
  String get date_of_birth;
  String get gender;
  String get address;
  String get phone;
  String get imageUrl;
  String get displayInfo;
  int? get totalDays;
  int? get absentDays;
  UserType get type;
  bool get isFirstLogin;
  get idNumber => null;
}

abstract class DashboardUser {
  int get id;
  String get name;
  String get gender;
  String get date_of_birth;
  String get address;
  String get phone_number;
  String get last_active_time;
  int get total_notifications;
  String get className;
  int get totalDays;
  int get absentDays;
}
