import 'package:MySchool/features/time_table/presentation/views/time_table.dart';
import 'package:flutter/widgets.dart';

import '../../../../chat/presentation/views/student_messages_view.dart';
import '../../../../dashbord/presentation/views/student_dashboard.dart';
import '../../../../school/presentation/views/student/student_profile_view.dart';

List<Widget> getStudentViews() => [
  const StudentDashBoard(),
  const StudentMessagesView(),
   const TimeTableView(),
  const StudentProfileView(),
];
