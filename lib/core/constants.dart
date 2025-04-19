import 'package:MySchool/features/main_wrapper/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/main_wrapper/domain/entities/user_role.dart';

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






Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear all saved user data

  Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (route) => false);
}

