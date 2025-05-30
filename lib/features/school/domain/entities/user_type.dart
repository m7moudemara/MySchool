// This file defines an enum for user types in a school management system.
enum UserType { student, teacher, parent }

// This file defines an interface for user entities in a school management system.
abstract class IUser {
  int get id;
  // String get id;
  String get name;
  String get imageUrl;
  String get displayInfo;
  int? get totalDays;
  int? get absentDays;
  UserType get type;
  bool get isFirstLogin;
  get idNumber => null;
}
