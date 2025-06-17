import 'package:MySchool/features/chat/presentation/views/parent_messages_view.dart';
import 'package:MySchool/features/grades/presentation/views/student_grades_view2.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/views/parent/children_details.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_homework_view.dart';
import 'package:MySchool/features/school/presentation/views/teacher/teacher_attendance.dart';
import 'package:MySchool/features/grades/presentation/views/teacher_result_view.dart';
import '../../../school/presentation/views/student/attendance_view.dart';
import '../../../homework/presentation/views/student_homework_view.dart';
import '../../../school/presentation/views/teacher/teacher_classes_view.dart';

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
    routeName: StudentHomeworkView.id,
    visibleFor: UserType.student,
  ),
  AcademicsItem(
    title: 'Results',
    iconPath: 'assets/results.png',
    routeName: StudentGradesView2.id,
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
    routeName: TeacherHomeworkView.id,
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
    visibleFor: UserType.guardian,
  ),
  AcademicsItem(
    title: 'Teachers',
    iconPath: 'assets/teachers.png',
    routeName: ParentMessagesView.id,
    visibleFor: UserType.guardian,
  ),
];
