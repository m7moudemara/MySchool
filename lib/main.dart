import 'package:MySchool/views/attendance_view.dart';
import 'package:MySchool/views/chat_view.dart';
import 'package:MySchool/views/sign_up/create_new_password_view.dart';
import 'package:MySchool/views/home_student_view.dart';
import 'package:MySchool/views/homework_view.dart';
import 'package:MySchool/views/notifications_view.dart';
import 'package:MySchool/views/sign_up/otp_verification_page.dart';
import 'package:MySchool/views/sign_up/reset_password_view.dart';
import 'package:MySchool/views/result_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/views/sign_up/forget_password_view.dart';
import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:MySchool/views/sign_up/select_account_view.dart';
import 'package:MySchool/views/sign_up/sign_up_view.dart';
import 'package:MySchool/views/intro_view/splash_screen.dart';

void main() {
  runApp(
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashView(),
        HomeView.id: (context) => HomeView(),
        SelectedAccountView.id: (context) => SelectedAccountView(),
        SignUpView.id: (context) => SignUpView(),
        LoginView.id: (context) => LoginView(),
        ForgetPasswordView.id: (context) => ForgetPasswordView(),
        ResetPasswordView.id: (context) => ResetPasswordView(),
        CreateNewPasswordView.id: (context) => CreateNewPasswordView(),
        OTPVerificationView.id: (context) => OTPVerificationView(),
        NotificationsView.id: (context) => NotificationsView(),
        HomeworkView.id: (context) => HomeworkView(),
        ResultView.id: (context) => ResultView(),
        AttendanceView.id: (context) => AttendanceView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: '/',
    ),
  );
}
