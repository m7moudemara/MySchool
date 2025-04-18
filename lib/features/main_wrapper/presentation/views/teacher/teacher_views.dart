import 'package:flutter/widgets.dart';

import '../../../../school/presentation/views/teacher/teacher_conversation_view.dart';
import '../../../../school/presentation/views/teacher/teacher_dashboard.dart';
import '../../../../school/presentation/views/teacher/teacher_group_chat_view.dart';
import '../../../../school/presentation/views/teacher/teacher_profile_view.dart';

List<Widget> getTeacherViews() => [
  const TeacherDashBoard(),
  const TeacherConversationView(),
  const TeacherGroupChatView(),
  const TeacherProfileView(),
];