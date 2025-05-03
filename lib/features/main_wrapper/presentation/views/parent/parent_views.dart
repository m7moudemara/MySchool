import 'package:MySchool/features/dashbord/presentation/views/parent_dashboard_view.dart';
import 'package:flutter/material.dart';

import '../../../../school/presentation/views/parent/parent_messages_view.dart';
import '../../../../school/presentation/views/parent/parent_group_chat_view.dart';
import '../../../../school/presentation/views/parent/parent_profile_view.dart';

List<Widget> getParentViews() => [
  const ParentDashboardView(),
  const ParentMessagesView(),
  const ParentGroupChatView(),
  const ParentProfileView(),
];