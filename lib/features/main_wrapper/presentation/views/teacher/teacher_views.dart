import 'package:MySchool/features/time_table/presentation/views/time_table.dart';
import 'package:flutter/widgets.dart';

import '../../../../chat/presentation/views/teacher_messages_view.dart';
import '../../../../dashbord/presentation/views/teacher_dashboard.dart';

import '../../../../school/presentation/views/teacher/teacher_profile_view.dart';

List<Widget> getTeacherViews() => [
  const TeacherDashBoard(),
  const TeacherMessagesView(),
  const TimeTableView(),
  const TeacherProfileView(),
];