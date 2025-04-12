import 'package:MySchool/views/student/student_conversation_view.dart';

import 'package:MySchool/views/student/student_group_chat_view.dart';
import 'package:MySchool/views/student/student_dashboard.dart';
import 'package:MySchool/views/student/student_profile_view.dart';
import 'package:MySchool/views/teacher/teacher_dashboard.dart';
import 'package:MySchool/views/teacher/teacher_group_chat_view.dart';
import 'package:MySchool/views/teacher/teacher_profile_view.dart';
import 'package:MySchool/widgets/buttom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

enum UserRole { student, teacher, parent }

class MainWrapper extends StatefulWidget {
  final UserRole userRole;

  const MainWrapper({super.key, required this.userRole});

  static final String id = "/MainWrapper";

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = _getPagesByRole(); 
  }

  List<Widget> _getPagesByRole() {
    switch (widget.userRole) {
      case UserRole.student:
        return [
          const StudentDashBoard(), 
          const StudentConversationView(), 
          const StudentGroupChatView(), 
          const StudentProfileView(), 
        ];
      case UserRole.teacher:
        return [
          const TeacherDashBoard(), 
          const StudentConversationView(), 
          const TeacherGroupChatView(), 
          const TeacherProfileView(), 
        ];
      case UserRole.parent:
        return [
          const StudentDashBoard(),
          const StudentConversationView(), 
          const StudentGroupChatView(),
          const StudentProfileView(),
        ];
    }
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
