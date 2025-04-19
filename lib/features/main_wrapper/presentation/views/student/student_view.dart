import 'package:flutter/widgets.dart';

import '../../../../school/presentation/views/student/student_conversation_view.dart';
import '../../../../school/presentation/views/student/student_dashboard.dart';
import '../../../../school/presentation/views/student/time_table_view.dart';
import '../../../../school/presentation/views/student/student_profile_view.dart';

List<Widget> getStudentViews() => [
  const StudentDashBoard(),
  const StudentConversationView(),
   TimeTableView(),
  const StudentProfileView(),
];
