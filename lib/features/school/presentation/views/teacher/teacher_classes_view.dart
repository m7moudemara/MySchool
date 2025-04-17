import 'package:MySchool/features/school/presentation/views/student/homework_view.dart';
import 'package:flutter/material.dart';

class TeacherClassesView extends StatelessWidget {
  static final String id = "/TeacherClassesView";

  const TeacherClassesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Classes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final item = classes[index];
          return _buildAcademicsItem(context, item);
        },
      ),
    );
  }

  Widget _buildAcademicsItem(BuildContext context, Classes item) {
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

final List<Classes> classes = [
  Classes(
    title: 'Class 1',
    iconPath: 'assets/classes.png',
    routeName: 'teacher_classes_route',
  ),
  Classes(
    title: 'Class 2',
    iconPath: 'assets/classes.png',
    routeName: HomeworkView.id,
  ),
  Classes(
    title: 'Class 3',
    iconPath: 'assets/classes.png',
    routeName: 'teacher_attendance_route',
  ),
  Classes(
    title: 'Class 4',
    iconPath: 'assets/classes.png',
    routeName: 'teacher_results_route',
  ),
];

class Classes {
  final String title;
  final String iconPath;
  final String routeName;

  Classes({
    required this.title,
    required this.iconPath,
    required this.routeName,
  });
}
