import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/holder.dart';
import 'package:MySchool/features/school/presentation/views/intro_view.dart';
import 'package:MySchool/features/school/presentation/views/splash_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_dashboard_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_group_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_profile_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_classes_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/features/school/presentation/views/student/student_dashboard.dart';
import 'package:MySchool/features/school/presentation/views/select_account_view.dart';
import 'package:MySchool/views/sign_up/sign_up_view.dart';
import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:MySchool/views/sign_up/forget_password_view.dart';
import 'package:MySchool/views/sign_up/reset_password_view.dart';
import 'package:MySchool/views/sign_up/create_new_password_view.dart';
import 'package:MySchool/views/sign_up/otp_verification_page.dart';
import 'package:MySchool/features/school/presentation/views/student/notifications_view.dart';
import 'package:MySchool/features/school/presentation/views/student/homework_view.dart';
import 'package:MySchool/features/school/presentation/views/result_view.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_view.dart';
import 'package:MySchool/features/school/presentation/views/student/student_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/student/student_conversation_view.dart';
import 'package:MySchool/features/school/presentation/views/student/student_group_chat_view.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';

import '../features/main_wrapper/domain/entities/user_role.dart';

class AppRoutes {
   static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == MainWrapperView.id) {
    final args = settings.arguments as RouteArguments;
    return MaterialPageRoute(
      builder: (context) => MainWrapperView(userRole: args.role),
    );
  }
  

  return null;
}


  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => SplashView(),
    IntroView.id : (context) => IntroView(),
    StudentDashBoard.id: (context) => StudentDashBoard(),
    SelectedAccountView.id: (context) => SelectedAccountView(),
    // SignUpView.id: (context) => SignUpView(),
    LoginView.id: (context) => LoginView(),
    ForgetPasswordView.id: (context) => ForgetPasswordView(),
    ResetPasswordView.id: (context) => ResetPasswordView(),
    CreateNewPasswordView.id: (context) => CreateNewPasswordView(),
    OTPVerificationView.id: (context) => OTPVerificationView(),
    NotificationsView.id: (context) => NotificationsView(),
    HomeworkView.id: (context) => HomeworkView(),
    ResultView.id : (context) => ResultView(),
    AttendanceView.id: (context) => AttendanceView(),
    StudentChatView.id: (context) => StudentChatView(),
    StudentConversationView.id: (context) => StudentConversationView(),
    StudentGroupChatView.id: (context) => StudentGroupChatView(),
    TeacherClassesView.id : (context)=> TeacherClassesView(),
    ParentDashboardView.id : (context)=> ParentDashboardView(),
    ParentChatView.id : (context)=> ParentChatView(),
    ParentGroupChatView.id : (context)=> ParentGroupChatView(),
    ParentProfileView.id: (context) => const ParentProfileView(),
    MyChildrenView.id: (context) =>  MyChildrenView(),
    
  };
}
class RouteArguments {
  final UserRole role;

  RouteArguments({required this.role});
}


