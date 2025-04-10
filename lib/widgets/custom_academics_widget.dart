import 'package:MySchool/constants.dart';
import 'package:MySchool/views/student/attendance_view.dart';
import 'package:MySchool/views/student/homework_view.dart';
import 'package:MySchool/views/student/result_view.dart';
import 'package:MySchool/views/teacher/teacher_classes_view.dart';
import 'package:flutter/material.dart';

class RoleBasedAcademicsCompo extends StatelessWidget {
  final UserRole currentUserRole;
  final List<AcademicsItem> items;

  const RoleBasedAcademicsCompo({
    super.key,
    required this.currentUserRole,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) => item.visibleFor == currentUserRole).toList();

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildAcademicsItem(context, item);
      },
    );
  }

  Widget _buildAcademicsItem(BuildContext context, AcademicsItem item) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, item.routeName),
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: Color(0xffE9F9F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Image.asset(item.iconPath, height: 60, width: 60),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  
}

final List<AcademicsItem> allAcademicsItems = [
  // للطلاب
  AcademicsItem(
    title: 'Attendance',
    iconPath: 'assets/attendance.png',
    routeName: AttendanceView.id,
    visibleFor: UserRole.student,
  ),
  AcademicsItem(
    title: 'Homework',
    iconPath: 'assets/homework.png',
    routeName: HomeworkView.id,
    visibleFor: UserRole.student,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: ResultView.id,
    visibleFor: UserRole.student,
  ),

  // للمدرسين
  AcademicsItem(
    title: 'Classes',
    iconPath: 'assets/classes.png',
    routeName: TeacherClassesView.id,
    visibleFor: UserRole.teacher,
  ),
  AcademicsItem(
    title: 'Homework',
    iconPath: 'assets/homework.png',
    routeName: HomeworkView.id,
    visibleFor: UserRole.teacher,
  ),
  AcademicsItem(
    title: 'Attendance',
    iconPath: 'assets/attendance.png',
    routeName: 'teacher_attendance_route',
    visibleFor: UserRole.teacher,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: 'teacher_results_route',
    visibleFor: UserRole.teacher,
  ),

  // للآباء
  AcademicsItem(
    title: 'Attendance',
    iconPath: 'assets/attendance.png',
    routeName: 'parent_attendance_route',
    visibleFor: UserRole.parent,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: 'parent_results_route',
    visibleFor: UserRole.parent,
  ),
];