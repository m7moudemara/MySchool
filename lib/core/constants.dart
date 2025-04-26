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
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            "Are you sure you want to log out ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF2F394B),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.02,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
  onTap: () {
  Navigator.of(context).pop(false);
  },
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    decoration: ShapeDecoration(
      
         color:  Color(0xFFDB4545),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Cancel',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        letterSpacing: 0.04,
      ),
    ),
  ),
),
                    GestureDetector(
  onTap: () {
   Navigator.of(context).pop(true);
  },
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
    decoration: ShapeDecoration(
        color:  Color(0xff0C46C4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Log Out',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        letterSpacing: 0.04,
      ),
    ),
  ),
),
              ],
            ),
          ],
        ),
  );

  if (shouldLogout == true) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
  }
}
