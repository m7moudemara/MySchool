import 'package:MySchool/constants.dart';
import 'package:MySchool/models/student.dart';
import 'package:MySchool/views/student/attendance_view.dart';
import 'package:MySchool/views/student/homework_view.dart';
import 'package:MySchool/views/student/notifications_view.dart';
import 'package:MySchool/views/student/result_view.dart';
import 'package:MySchool/widgets/custom_academics_widget.dart';
import 'package:MySchool/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

class StudentDashBoard extends StatefulWidget {
  static String id = '/StudentDashBoard';

  const StudentDashBoard({super.key});

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NotificationsView.id);
                      },
                      icon: Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Hi there, Welcome!",
                    style: TextStyle(
                      color: Color(0xff3F3D56),
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: UserCard(
                  user: Student(
                    name: 'Mahmoud Ahmed',
                    className: 'Class 5',
                    imageUrl: 'assets/Mini Avatar.png',
                    totalDays: 100,
                    absentDays: 30,
                     id: '', 
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: const Text(
                  'Academics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                 child: RoleBasedAcademicsCompo(
                  currentUserRole: UserRole.student,
                  items: allAcademicsItems,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


