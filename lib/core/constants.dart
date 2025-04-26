import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppColors {
  static const Color kPrimaryColor = Color(0xff103568);
  static const Color absentColor = Color(0xffC53F3F);

  static const Color kSecondaryColor = Color(0xff3620C2);
  static const Color kBackgroundColor = Color(0xffB5D7FF);
  static const Color kDarkColor = Color(0xff2F496E);
  static const Color kWhiteColor = Color(0xffFFFFFF);

  // GradesView colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF7B7B7B);

  static const Color scoreBackground = Color(0xFFDBF4FF);
  static const Color scoreText = Color(0xFF0C5D85);

  static const Color gradeBackground = Color(0xFFECE4FD);
  static const Color gradeText = Color(0xFF5B3DC5);

   // Colors based on grade
  static const Color gradeA = Color(0xff2E7D32); // Green
  static const Color gradeB = Color(0xff0277BD); // Blue
  static const Color gradeC = Color(0xffF9A825); // Amber
  static const Color gradeD = Color(0xffEF6C00); // Orange
  static const Color gradeF = Color(0xffC62828); // Red
}

class AppTexts {
  static const String helloText = "Hello, Sign Up to start using our app";
  static const String haveAccountText = "Have an account? ";
  static const String loginText = "Login";
}






Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear all saved user data

  Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
}

