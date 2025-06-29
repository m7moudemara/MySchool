import 'package:MySchool/features/main_wrapper/presentation/views/parent/parent_views.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/core/widgets/buttom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

import 'student/student_view.dart';
import 'teacher/teacher_views.dart';

class MainWrapperView extends StatefulWidget {
  final UserType userRole;
  static final String id = "/MainWrapper";
  const MainWrapperView({super.key, required this.userRole});

  @override
  State<MainWrapperView> createState() => _MainWrapperViewState();
}

class _MainWrapperViewState extends State<MainWrapperView> {
  List<BottomNavigationBarItem> _getNavBarItemsByRole() {
    switch (widget.userRole) {
      case UserType.student:
        return [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 26), //? When Icon Unselected
            activeIcon: Icon(
              Icons.home_filled,
              size: 26,
            ), //? When Icon Selected
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined, size: 26),
            activeIcon: Icon(Icons.chat, size: 26),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 26),
            activeIcon: Icon(Icons.calendar_today, size: 26),
            label: 'Time Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26),
            activeIcon: Icon(Icons.person, size: 26),
            label: 'Profile',
          ),
        ];
      case UserType.teacher:
        return [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 26), //? When Icon Unselected
            activeIcon: Icon(
              Icons.home_filled,
              size: 26,
            ), //? When Icon Selected
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined, size: 26),
            activeIcon: Icon(Icons.chat, size: 26),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 26),
            activeIcon: Icon(Icons.calendar_today, size: 26),
            label: 'Time Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26),
            activeIcon: Icon(Icons.person, size: 26),
            label: 'Profile',
          ),
        ];
      case UserType.guardian:
        return [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 26), //? When Icon Unselected
            activeIcon: Icon(
              Icons.home_filled,
              size: 26,
            ), //? When Icon Selected
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26),
            activeIcon: Icon(Icons.person, size: 26),
            label: 'Profile',
          ),
        ];
      default:
        return [];
    }
  }

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
      case UserType.student:
        //! If User is Student
        return getStudentViews();
      case UserType.teacher:
        //! If User is Teacher
        return getTeacherViews();
      case UserType.guardian:
        // case UserType.parent:
        //! If User is Parent
        return getParentViews();
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
        physics: const NeverScrollableScrollPhysics(),
        children: _views,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _getNavBarItemsByRole(),
      ),
    );
  }
}
