import 'package:MySchool/features/school/presentation/views/parent/parent_dashboard_view.dart';
import 'package:flutter/material.dart';

import '../../../../school/presentation/views/parent/parent_chat_view.dart';
import '../../../../school/presentation/views/parent/parent_group_chat_view.dart';
import '../../../../school/presentation/views/parent/parent_profile_view.dart';

List<Widget> getParentViews() => [
  const ParentDashboardView(),
  const ParentChatView(),
  const ParentGroupChatView(),
  const ParentProfileView(),
];