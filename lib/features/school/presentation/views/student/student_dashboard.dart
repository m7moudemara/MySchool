import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/school/data/config/academics_items_config.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/notifications/presentation/views/notifications_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/widgets/custom_academics_widget.dart';
import 'package:MySchool/features/school/presentation/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
class StudentDashBoard extends StatefulWidget {
  static String id = '/StudentDashBoard';

  const StudentDashBoard({super.key});

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
Student? student;  

 @override
void initState() {
  super.initState();

  final user = AppSession.currentUser;

  if (user is Student) {
    student = user;
  } else {
    student = null;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          student == null
              ? const Center(child: Text("No student data available"))
              : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NotificationsView.id,
                                );
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
                              isFirstLogin: student?.isFirstLogin ?? false, 
                            name: student?.name ?? 'Student Name',
                            className: 'Class 5',
                            imageUrl:
                                student?.imageUrl ?? 'assets/Mini Avatar.png',
                            totalDays: 100,
                            absentDays: 30,
                            id: '', parentId: '',
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
                          currentUserRole: UserType.student,
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
