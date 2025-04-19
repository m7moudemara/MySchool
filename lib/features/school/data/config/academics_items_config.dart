import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/features/school/presentation/views/teacher/home_work.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_attendance.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_result_view.dart';

import '../../../main_wrapper/domain/entities/user_role.dart';
import '../../presentation/views/result_view.dart';
import '../../presentation/views/student/attendance_view.dart';
import '../../presentation/views/student/homework_view.dart';
import '../../presentation/views/teacher/teacher_classes_view.dart';

class AcademicsItem {
  final String title;
  final String iconPath;
  final String routeName;
  final UserType visibleFor;

  const AcademicsItem({
    required this.title,
    required this.iconPath,
    required this.routeName,
    required this.visibleFor,
  });
}

final List<AcademicsItem> allAcademicsItems = [
  //! students
  AcademicsItem(
    title: 'Attendance',
    iconPath: 'assets/attendance.png',
    routeName: AttendanceView.id,
    visibleFor: UserType.student,
  ),
  AcademicsItem(
    title: 'Homework',
    iconPath: 'assets/homework.png',
    routeName: HomeworkView.id,
    visibleFor: UserType.student,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: ResultView.id,
    visibleFor: UserType.student,
  ),

  //! teachers
  AcademicsItem(
    title: 'Classes',
    iconPath: 'assets/classes.png',
    routeName: TeacherClassesView.id,
    visibleFor: UserType.teacher,
  ),
  AcademicsItem(
    title: 'Homework',
    iconPath: 'assets/homework.png',
    routeName: TeacherAssignmentsView.id,
    visibleFor: UserType.teacher,
  ),
  AcademicsItem(
    title: 'Attendance',
    iconPath: 'assets/attendance.png',
    routeName: TeacherAttendanceView.id,
    visibleFor: UserType.teacher,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: TeacherResultView.id,
    visibleFor: UserType.teacher,
  ),

  //! parents
  AcademicsItem(
    title: 'My Children',
    iconPath: 'assets/children.png',
    routeName: MyChildrenView.id,
    visibleFor: UserType.parent,
  ),
  AcademicsItem(
    title: 'Teachers',
    iconPath: 'assets/teachers.png',
    routeName: 'parent_results_route',
    visibleFor: UserType.parent,
  ),
];
