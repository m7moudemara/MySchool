import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';

import '../../../main_wrapper/domain/entities/user_role.dart';
import '../../presentation/views/result_view.dart';
import '../../presentation/views/student/attendance_view.dart';
import '../../presentation/views/student/homework_view.dart';
import '../../presentation/views/teacher/teacher_classes_view.dart';

class AcademicsItem {
  final String title;
  final String iconPath;
  final String routeName;
  final UserRole visibleFor;

  const AcademicsItem({
    required this.title,
    required this.iconPath,
    required this.routeName,
    required this.visibleFor,
  });
}
 final List<AcademicsItem> allAcademicsItems = [
  
  // students
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

  // teachers
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

  // parents
  AcademicsItem(
    title: 'My Children',
    iconPath: 'assets/children.png',
    routeName: MyChildrenView.id,
    visibleFor: UserRole.parent,
  ),
  AcademicsItem(
    title: 'Teachers',
    iconPath: 'assets/teachers.png',
    routeName: 'parent_results_route',
    visibleFor: UserRole.parent,
  ),
];
