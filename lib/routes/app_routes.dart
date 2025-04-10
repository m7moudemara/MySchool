import 'package:MySchool/views/intro_view/splash_screen.dart';
import 'package:MySchool/views/teacher/teacher_chat_view.dart';
import 'package:MySchool/views/teacher/teacher_classes_view.dart';
import 'package:MySchool/views/teacher/teacher_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/views/student/student_dashboard.dart';
import 'package:MySchool/views/sign_up/select_account_view.dart';
import 'package:MySchool/views/sign_up/sign_up_view.dart';
import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:MySchool/views/sign_up/forget_password_view.dart';
import 'package:MySchool/views/sign_up/reset_password_view.dart';
import 'package:MySchool/views/sign_up/create_new_password_view.dart';
import 'package:MySchool/views/sign_up/otp_verification_page.dart';
import 'package:MySchool/views/student/notifications_view.dart';
import 'package:MySchool/views/student/homework_view.dart';
import 'package:MySchool/views/student/result_view.dart';
import 'package:MySchool/views/student/attendance_view.dart';
import 'package:MySchool/views/student/student_chat_view.dart';
import 'package:MySchool/views/student/student_conversation_view.dart';
import 'package:MySchool/views/student/student_group_chat_view.dart';
import 'package:MySchool/views/main_wrapper.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => SplashView(),
    StudentDashBoard.id: (context) => StudentDashBoard(),
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
    StudentChatView.id: (context) => StudentChatView(),
    StudentConversationView.id: (context) => StudentConversationView(),
    StudentGroupChatView.id: (context) => StudentGroupChatView(),
    MainWrapper.id: (context) => MainWrapper(userRole: UserRole.student),
    TeacherClassesView.id : (context)=> TeacherClassesView(),
  };
}