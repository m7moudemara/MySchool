import 'package:MySchool/core/presentation/intro/presentation/views/intro_view.dart';
import 'package:MySchool/core/presentation/view/decider_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/features/school/presentation/views/teacher/create_homework.dart';
import 'package:MySchool/features/school/presentation/views/teacher/home_work.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_attendance.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_homework_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_result_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_dashboard_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_group_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/parent/parent_profile_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_classes_view.dart';
import 'package:MySchool/features/time_table/presentation/views/time_table.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/features/school/presentation/views/student/student_dashboard.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
import 'package:MySchool/features/notifications/presentation/views/notifications_view.dart';
import 'package:MySchool/features/school/presentation/views/student/homework_view.dart';
import 'package:MySchool/features/school/presentation/views/result_view.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_view.dart';
import 'package:MySchool/features/school/presentation/views/student/student_chat_view.dart';
import 'package:MySchool/features/school/presentation/views/student/student_conversation_view.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';

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
    '/': (context) => const DeciderView(),
    IntroView.id: (context) => IntroView(),
    LoginView.id: (context) => LoginView(),
    StudentDashBoard.id: (context) => StudentDashBoard(),
    CreateNewPasswordView.id: (context) => CreateNewPasswordView(),
    NotificationsView.id: (context) => NotificationsView(),
    HomeworkView.id: (context) => HomeworkView(),
    ResultView.id: (context) => ResultView(),
    AttendanceView.id: (context) => AttendanceView(),
    StudentChatView.id: (context) => StudentChatView(),
    StudentConversationView.id: (context) => StudentConversationView(),
    TimeTableView.id: (context) => TimeTableView(),
    TeacherClassesView.id: (context) => TeacherClassesView(),
    ParentDashboardView.id: (context) => ParentDashboardView(),
    ParentChatView.id: (context) => ParentChatView(),
    ParentGroupChatView.id: (context) => ParentGroupChatView(),
    ParentProfileView.id: (context) => const ParentProfileView(),
    MyChildrenView.id: (context) => MyChildrenView(),
    TeacherHomeworkView.id: (context) => const TeacherHomeworkView(),
    TeacherAssignmentsView.id: (context) => const TeacherAssignmentsView(),
    CreateHomeworkview.id: (context) => const CreateHomeworkview(),
    TeacherResultView.id: (context) => const TeacherResultView(),
    TeacherAttendanceView.id: (context) => const TeacherAttendanceView(),
  };
}

class RouteArguments {
  final UserType role;

  RouteArguments({required this.role});
}
