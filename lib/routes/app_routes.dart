import 'package:MySchool/core/presentation/intro/presentation/views/intro_view.dart';
import 'package:MySchool/core/presentation/view/decider_view.dart';
import 'package:MySchool/features/profile/presentation/views/help_center_view.dart';
import 'package:MySchool/features/profile/presentation/views/personal_data_view.dart';
import 'package:MySchool/features/profile/presentation/views/setting_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/features/homework/presentation/views/create_homework.dart';
import 'package:MySchool/features/homework/presentation/views/home_work.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_attendance.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_homework_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_result_view.dart';
import 'package:MySchool/features/chat/presentation/views/parent_messages_view.dart';
import 'package:MySchool/features/dashbord/presentation/views/parent_dashboard_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_classes_view.dart';
import 'package:MySchool/features/time_table/presentation/views/parent_time_table_view.dart';
import 'package:MySchool/features/time_table/presentation/views/student_time_table_view.dart';
import 'package:MySchool/features/time_table/presentation/views/teacher_time_table_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/features/dashbord/presentation/views/student_dashboard.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
import 'package:MySchool/features/notifications/presentation/views/notifications_view.dart';
import 'package:MySchool/features/homework/presentation/views/homework_view.dart';
import 'package:MySchool/features/grades/presentation/views/grades_view.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_view.dart';
import 'package:MySchool/features/chat/presentation/views/chat_view.dart';
import 'package:MySchool/features/chat/presentation/views/student_messages_view.dart';
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
    GradesView.id : (context) => GradesView(),
    CreateNewPasswordView.id: (context) => CreateNewPasswordView(),
    NotificationsView.id: (context) => NotificationsView(),
    HomeworkView.id: (context) => HomeworkView(),
    AttendanceView.id: (context) => AttendanceView(),
    ChatView.id: (context) => ChatView(),
    StudentMessagesView.id: (context) => StudentMessagesView(),
    TeacherClassesView.id: (context) => TeacherClassesView(),
    ParentDashboardView.id: (context) => ParentDashboardView(),
    ParentMessagesView.id: (context) => ParentMessagesView(),
    MyChildrenView.id: (context) => MyChildrenView(),
    TeacherHomeworkView.id: (context) => const TeacherHomeworkView(),
    TeacherAssignmentsView.id: (context) => const TeacherAssignmentsView(),
    CreateHomeworkview.id: (context) => const CreateHomeworkview(),
    TeacherResultView.id: (context) => const TeacherResultView(),
    TeacherAttendanceView.id: (context) => const TeacherAttendanceView(),
    PersonalDataView.id : (context) => const PersonalDataView(),
    SettingsView.id : (context) => const SettingsView(),
    HelpCenterView.id : (context) => const HelpCenterView(),
    //! Time Table 
    StudentTimeTableView.id: (context) => StudentTimeTableView(),
    TeacherTimeTableView.id: (context) => TeacherTimeTableView(),
    ParentTimeTableView.id: (context) => ParentTimeTableView(),

  };
}

class RouteArguments {
  final UserType role;

  RouteArguments({required this.role});
}
