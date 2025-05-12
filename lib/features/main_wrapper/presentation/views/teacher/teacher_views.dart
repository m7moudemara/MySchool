import 'package:MySchool/features/profile/presentation/views/profile_view.dart';
import 'package:MySchool/features/time_table/presentation/views/time_table.dart';
import 'package:flutter/widgets.dart';

import '../../../../chat/presentation/views/teacher_messages_view.dart';
import '../../../../dashbord/presentation/views/teacher_dashboard.dart';



List<Widget> getTeacherViews() => [
  const TeacherDashBoard(),
  const TeacherMessagesView(),
  const TimeTableView(),
  const ProfileView(),
];