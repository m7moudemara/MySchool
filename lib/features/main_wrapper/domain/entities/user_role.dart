
import 'package:MySchool/features/school/domain/entities/user_type.dart';

enum UserRole { student, teacher, parent }

UserType parseUserType(UserRole role) {
  switch(role) {
    case UserRole.student: return UserType.student;
    case UserRole.teacher: return UserType.teacher;
    case UserRole.parent: return UserType.parent;
  }
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


