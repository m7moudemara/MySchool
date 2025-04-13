import 'package:MySchool/constants.dart';
import 'package:MySchool/views/parent/parent_dashboard_view.dart';
import 'package:MySchool/views/parent/parent_chat_view.dart';
import 'package:MySchool/views/parent/parent_group_chat_view.dart';
import 'package:MySchool/views/parent/parent_profile_view.dart';
import 'package:MySchool/views/student/student_conversation_view.dart';
import 'package:MySchool/views/student/student_group_chat_view.dart';
import 'package:MySchool/views/student/student_dashboard.dart';
import 'package:MySchool/views/student/student_profile_view.dart';
import 'package:MySchool/views/teacher/teacher_dashboard.dart';
import 'package:MySchool/views/teacher/teacher_group_chat_view.dart';
import 'package:MySchool/views/teacher/teacher_profile_view.dart';
import 'package:MySchool/widgets/buttom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  final UserRole userRole;
  static final String id = "/MainWrapper";
  const MainWrapper({super.key, required this.userRole});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0; // Track the currently selected page index
  final PageController _pageController = PageController();

  // List of views for each role. The list is determined by the user role.
  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = _getViewByRole(); // Initialize views based on user role
  }

  //! Return list of views according to the user role
  List<Widget> _getViewByRole() {
    switch (widget.userRole) {
      case UserRole.student:
        //! If User is Student
        return [
          const StudentDashBoard(),
          const StudentConversationView(),
          const StudentGroupChatView(),
          const StudentProfileView(),
        ];
      case UserRole.teacher:
        //! If User is Teacher
        return [
          const TeacherDashBoard(),
          const StudentConversationView(),
          const TeacherGroupChatView(),
          const TeacherProfileView(),
        ];
      case UserRole.parent:
        //! If User is Parent
        return [
          const ParentDashboardView(), // Temporary placeholder for Parent Dashboard
          const ParentChatView(), // Temporary placeholder for Parent Conversation
          const ParentGroupChatView(), // Temporary placeholder for Parent Group Chat
          const ParentProfileView(), // Done
        ];
      default:
        return []; // Fallback if no role matches
    }
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index); // Update the index
    _pageController.jumpToPage(index); // Go To Tapped View
  }

  @override
  void dispose() {
    _pageController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe gestures
        children: _views,
        onPageChanged: (index) {
          setState(() => _currentIndex = index); // Sync index with page change
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex, // Highlight selected tab
        onTap: _onItemTapped, // Handle navigation tab taps
      ),
    );
  }
}
