import 'package:MySchool/features/grades/presentation/cubits/student/grade_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/teacher/cubit/teacher_grade_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/teacher/cubit/teacher_grade_state.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherResultView extends StatefulWidget {
  const TeacherResultView({super.key});
  static const String id = '/TeacherResultView';

  @override
  State<TeacherResultView> createState() => _TeacherResultViewState();
}

class _TeacherResultViewState extends State<TeacherResultView> {
  String selectedTerm = 'First';
  late String selectedSubject;

  // Dropdown options
  final List<String> terms = ['First', 'Second'];
  final List<String> subjects = [];

  // Students list and their results
  List<StudentResult> students = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeacherGradeCubit>(context).loadGrades();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Result',
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
        child: BlocConsumer<TeacherGradeCubit, TeacherGradeState>(
          listener: (context, state) {
            if (state is TeacherGradeLoaded) {
              List<StudentResult> sx =
                  state.studentResults.whereType<StudentResult>().toList();
              setState(() {
                students =
                    state.studentResults.whereType<StudentResult>().toList();
                for (var item in sx) {
                  if (!subjects.contains(item.subjectName)) {
                    subjects.add(item.subjectName);
                  }
                }
                selectedSubject = subjects[0];
              });
            }
          },
          builder: (context, state) {
            if (state is TeacherGradeLoading) {
              return Center(child: Image.asset('assets/loading.gif'));
            } else if (state is TeacherGradeLoaded) {
              return SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  constraints: BoxConstraints(minHeight: screenHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Back button

                      // Class, term and subject selection row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //! Term dropdown
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Term',
                                    style: TextStyle(
                                      color: Color(0xFFB6C8E2),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.04,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedTerm,
                                    items:
                                        terms.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Color(0xFF2F394B),
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.04,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedTerm = newValue!;
                                        BlocProvider.of<TeacherGradeCubit>(
                                          context,
                                        ).selectTerm(
                                          selectedTerm,
                                          selectedSubject,
                                        );
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ],
                              ),
                            ),

                            //! Subject dropdown
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Subject',
                                    style: TextStyle(
                                      color: Color(0xFFB6C8E2),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.04,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedSubject,
                                    items:
                                        subjects.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                color: Color(0xFF2F394B),
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.04,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedSubject = newValue!;
                                        BlocProvider.of<TeacherGradeCubit>(
                                          context,
                                        ).selectTerm(
                                          selectedTerm,
                                          selectedSubject,
                                        );
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Students table header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Students',
                                style: TextStyle(
                                  color: Color(0xFF2F394B),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.02,
                                ),
                              ),
                              Text(
                                'Grades',
                                style: TextStyle(
                                  color: Color(0xFF2F394B),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Students list
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            var item = students[index];
                            return _buildStudentItem(item, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('error'));
            }
          },
        ),
      ),

      // Save button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0C46C4),
            minimumSize: Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: _saveResults,
          child: Text(
            'Save Changes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentItem(StudentResult student, int index) {
    final isEven = index % 2 == 0;
    final textColor =
        student.grade >= 50 ? Color(0xFF0C46C4) : Color(0xFFF76565);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEven ? Color(0xFFFAFAFA) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              student.name,
              style: TextStyle(
                color: Color(0xFF495D80),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.04,
              ),
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () => _editStudentGrade(student),
            child: Container(
              width: 80,
              child: Text(
                '${student.grade}/${student.total}',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editStudentGrade(StudentResult student) {
    final gradeController = TextEditingController(
      text: student.grade.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit Grade'),
            content: TextField(
              controller: gradeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xFFDB4545),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.04,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final newGrade = int.parse(gradeController.text);
                      setState(() {
                        student.grade = newGrade;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      decoration: ShapeDecoration(
                        color: Color(0xff0C46C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  void _saveResults() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Save Changes'),
            content: Text(
              'Are you sure you want to save changes for ${students.length} students?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<TeacherGradeCubit>(
                    context,
                  ).saveGrade(students);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Changes saved successfully')),
                  );
                  // Here you would add code to save to database
                },
                child: Text('Confirm'),
              ),
            ],
          ),
    );
  }
}

class StudentResult {
  int id;
  String name;
  String subjectName;
  int grade;
  int total;
  int term;
  int studentId;
  int subjectId;

  StudentResult({
    required this.id,
    required this.name,
    required this.subjectName,
    required this.grade,
    required this.total,
    required this.term,
    required this.studentId,
    required this.subjectId,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) {
    return StudentResult(
      id: json['id'],
      name: json['student']['name'] as String,
      subjectName: json['subject']['name'] as String,
      grade: json['mark'] as int,
      total: json['total'] ?? 100,
      term: json['term_number'] ?? 1,
      studentId: json['student']['id'],
      subjectId: json['subject']['id'],
    );
  }
}
