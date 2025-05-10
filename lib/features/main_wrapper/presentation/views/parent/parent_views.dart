import 'package:MySchool/features/dashbord/presentation/views/parent_dashboard_view.dart';
import 'package:MySchool/features/profile/presentation/views/profile_view.dart';
import 'package:MySchool/features/time_table/presentation/views/time_table.dart';
import 'package:flutter/material.dart';

import '../../../../chat/presentation/views/parent_messages_view.dart';



List<Widget> getParentViews() => [
  const ParentDashboardView(),
  const ParentMessagesView(),
  const TimeTableView(),
  const ProfileView(),
];