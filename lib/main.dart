import 'package:MySchool/views/create_new_password_view.dart';
import 'package:MySchool/views/home_view.dart';
import 'package:MySchool/views/otp_verification_page.dart';
import 'package:MySchool/views/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/views/forget_password_view.dart';
import 'package:MySchool/views/login_view.dart';
import 'package:MySchool/views/select_account_view.dart';
import 'package:MySchool/views/sign_up_view.dart';
import 'package:MySchool/views/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashView(),
        HomeView.id :(context)=>HomeView(),
        SelectedAccountView.id: (context) => SelectedAccountView(),
        SignUpView.id: (context) => SignUpView(),
        LoginView.id: (context) => LoginView(),
        ForgetPasswordView.id: (context) => ForgetPasswordView(),
        ResetPasswordView.id: (context) => ResetPasswordView(),
        CreateNewPasswordView.id : (context)=>CreateNewPasswordView(),
        OTPVerificationView.id: (context) => OTPVerificationView(),
      },
      initialRoute: '/',
    ),
  );
}