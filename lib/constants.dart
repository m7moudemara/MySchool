import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors{
  static const Color kPrimaryColor = Color(0xff103568);

static const Color kSecondaryColor = Color(0xff3620C2);

static const Color kBackgroundColor = Color(0xffB5D7FF);

static const Color kDarkColor = Color(0xff2F496E);

static const Color kWhiteColor = Color(0xffFFFFFF);
}
class AppTexts {
  static const String helloText = "Hello, Sign Up to start using our app";
  static const String haveAccountText = "Have an account? ";
  static const String loginText = "Login";
}


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

class AcademicsItem {
  final String title;
  final String iconPath;
  final String routeName;
  final UserRole visibleFor;

  AcademicsItem({
    required this.title,
    required this.iconPath,
    required this.routeName,
    required this.visibleFor,
  });
}



Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear all saved user data

  Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
}

