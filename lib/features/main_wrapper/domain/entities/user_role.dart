import '../../../school/domain/entities/user_type.dart';

enum UserRole {
  student,
  teacher,
  parent,
}

UserRole parseUserRole(String role) {
  switch (role.toLowerCase()) {
    case 'student':
      return UserRole.student;
    case 'teacher':
      return UserRole.teacher;
    case 'parent':
      return UserRole.parent;
    default:
      throw Exception("Unknown user role: $role");
  }
}


