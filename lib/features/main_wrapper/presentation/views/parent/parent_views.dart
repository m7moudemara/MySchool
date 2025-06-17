import 'package:MySchool/features/dashbord/presentation/views/parent_dashboard_view.dart';
import 'package:MySchool/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';




List<Widget> getParentViews() => [
  const ParentDashboardView(),
  const ProfileView(),
];