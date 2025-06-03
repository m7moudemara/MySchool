import 'package:MySchool/features/time_table/presentation/views/student_time_table_view.dart';
import 'package:flutter/widgets.dart';

import '../../../../chat/presentation/views/student_messages_view.dart';
import '../../../../dashbord/presentation/views/student_dashboard.dart';
import '../../../../profile/presentation/views/profile_view.dart';

List<Widget> getStudentViews() => [
  const StudentDashBoard(),
  const StudentMessagesView(),
   const StudentTimeTableView(),
  const ProfileView(),
];
