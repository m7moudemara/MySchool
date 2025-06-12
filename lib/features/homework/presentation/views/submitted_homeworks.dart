import 'package:MySchool/features/homework/presentation/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../school/presentation/views/teacher/data/class_model.dart';
import '../../data/home_work_repository.dart';
import '../../data/teacher/cubit/teacher_view_homework_cubit.dart';

class ViewAttachmentPage extends StatefulWidget {
  final int homeWorkId;
  final int classId;
  const ViewAttachmentPage({
    super.key,
    required this.homeWorkId,
    required this.classId,
  });

  @override
  State<ViewAttachmentPage> createState() => _ViewAttachmentPageState();
}

class _ViewAttachmentPageState extends State<ViewAttachmentPage> {
  List<StudentHomeWorkResult> students = const [];
  List<ClassStudentModel> studentsclass = const [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeacherViewHomeworkCubit>(
      context,
    ).getSubmissions(widget.homeWorkId, widget.classId);
  }

  getIsSubmitted(int id) {
    // print(id);
    // print(studentsclass[0].id);
    // print(studentsclass[1].id);
    // print('sssssssssss');
    List<StudentHomeWorkResult> xx =
        students.where((element) => element.studentId == id).toList();
    if (xx.isEmpty) {
      return false;
    } else {
      return true;
    }
    // print(xx);
    // print('bbbbbbbbbbbbb');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C46C4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'View Homework',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! Total Students
                  Text(
                    'Total Students:${students.length}',
                    style: TextStyle(fontSize: 16),
                  ),
                  //! Search
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        cursorHeight: 16,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          contentPadding: EdgeInsets.symmetric(vertical: 2),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              _buildButtons(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocConsumer<
                  TeacherViewHomeworkCubit,
                  TeacherViewHomeworkState
                >(
                  listener: (context, state) {
                    if (state is HomeWorksSubmissionsLoaded) {
                      setState(() {
                        students = state.homeWorks;
                        studentsclass = state.students;
                      });
                    }
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: studentsclass.length,
                      itemBuilder: (context, index) {
                        final student = studentsclass[index];
                        bool xy = getIsSubmitted(student.id);
                        return StudentCard(
                          name: student.name,
                          number: 'Number ${index + 1}',
                          imageUrl: student.className,
                          submitted: xy,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _roundedButton('Missing', const Color(0xFFF2ABFE))),
        Expanded(child: _roundedButton('Submitted', const Color(0xFF0C46C4))),
      ],
    );
  }

  Widget _roundedButton(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(47),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
