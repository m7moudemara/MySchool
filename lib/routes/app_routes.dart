import 'package:MySchool/core/presentation/intro/presentation/views/intro_view.dart';
import 'package:MySchool/core/presentation/view/decider_view.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import '../features/admin/presentation/views/admin_view.dart';
import '../features/admin/presentation/views/classes/add_class_view.dart';
import '../features/admin/presentation/views/fees/fees_view.dart';
import '../features/admin/presentation/views/parent/parents_view.dart';
import '../features/admin/presentation/views/result/results_view.dart';
import '../features/admin/presentation/views/students/add_students_view.dart';
import '../features/admin/presentation/views/subjects/add_subjects_view.dart';
import '../features/admin/presentation/views/teacher/add_teachers_view.dart';
import '../features/admin/presentation/views/timetable/timetables_view.dart';
import 'package:MySchool/features/profile/presentation/views/help_center_view.dart';
import 'package:MySchool/features/profile/presentation/views/personal_data_view.dart';
import 'package:MySchool/features/profile/presentation/views/setting_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_create_homework_view.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_homework_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_attendance.dart';
import 'package:MySchool/features/homework/presentation/views/student_submitted_homework_view.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
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
import 'package:MySchool/features/homework/presentation/views/student_homework_view.dart';
import 'package:MySchool/features/grades/presentation/views/student_grades_view.dart';
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
    if (settings.name == ChatView.id) {
      final args = settings.arguments as Map;
      return MaterialPageRoute(builder: (context) => ChatView(messagess: args));
    }
    if (settings.name == StudentGradesView.id) {
      final args = settings.arguments as Student;
      return MaterialPageRoute(
        builder: (context) => StudentGradesView(student: args),
      );
    }

    return null;
  }

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const DeciderView(),
    IntroView.id: (context) => IntroView(),
    LoginView.id: (context) => LoginView(),
    StudentDashBoard.id: (context) => StudentDashBoard(),
    // StudentGradesView.id: (context) => StudentGradesView(),
    CreateNewPasswordView.id: (context) => CreateNewPasswordView(),
    NotificationsView.id: (context) => NotificationsView(),
    StudentHomeworkView.id: (context) => StudentHomeworkView(),
    AttendanceView.id: (context) => AttendanceView(),
    // ChatView.id: (context) {
    //   final argumentss = ModalRoute.of(context)!.settings.arguments as String;
    //   return ChatView(messagess: argumentss);
    // },
    StudentMessagesView.id: (context) => StudentMessagesView(),
    TeacherClassesView.id: (context) => TeacherClassesView(),
    ParentDashboardView.id: (context) => ParentDashboardView(),
    ParentMessagesView.id: (context) => ParentMessagesView(),
    MyChildrenView.id: (context) => MyChildrenView(),
    TeacherHomeworkView.id: (context) => const TeacherHomeworkView(),
    TeacherHomeworkView.id: (context) => const TeacherHomeworkView(),
    TeacherCreateHomeworkview.id:
        (context) => const TeacherCreateHomeworkview(),
    TeacherResultView.id: (context) => const TeacherResultView(),
    TeacherAttendanceView.id: (context) => const TeacherAttendanceView(),
    PersonalDataView.id: (context) => const PersonalDataView(),
    SettingsView.id: (context) => const SettingsView(),
    HelpCenterView.id: (context) => const HelpCenterView(),
    //! Time Table
    StudentTimeTableView.id: (context) => StudentTimeTableView(),
    TeacherTimeTableView.id: (context) => TeacherTimeTableView(),
    ParentTimeTableView.id: (context) => ParentTimeTableView(),

    StudentSubmittedHomeworkView.id:
        (context) => StudentSubmittedHomeworkView(),
    //! Admin
    AdminView.id: (context) => AdminView(),
    AddClassView.id: (context) => AddClassView(),
    AddSubjectView.id: (context) => AddSubjectView(),
    AddTeachersView.id: (context) => AddTeachersView(),
    ParentsView.id: (context) => ParentsView(),
    StudentsView.id: (context) => StudentsView(),
    TimetablesView.id: (context) => TimetablesView(),
    FeesView.id: (context) => FeesView(),
    ResultsView.id: (context) => ResultsView(),
  };
}

class RouteArguments {
  final UserType role;

  RouteArguments({required this.role});
}
