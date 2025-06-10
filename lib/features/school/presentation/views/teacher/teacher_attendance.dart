import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../student/data/attendance_model.dart';
import 'data/class_model.dart';
import 'data/classes_cubit.dart';

class TeacherAttendanceView extends StatefulWidget {
  const TeacherAttendanceView({super.key});
  static const String id = "/TeacherAttendanceView";

  @override
  State<TeacherAttendanceView> createState() => _TeacherAttendanceViewState();
}

class _TeacherAttendanceViewState extends State<TeacherAttendanceView> {
  // Class data
  String selectedClass = '';
  int? selectedClassId = 0;
  String selectedSubject = 'English';
  DateTime selectedDate = DateTime.now();

  // Dropdown options
  List<String> classes = [];
  List<TeacherAttendanceForStudent> students = [];
  List<TeacherAttendanceForStudent> studentsx = [];
  List<ClassStudentModel> returnedClasses = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClassesCubit>(context).getClasses();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Attendance',
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
        child: BlocConsumer<ClassesCubit, ClassesState>(
          listener: (context, state) {
            if (state is ClassesLoaded) {
              returnedClasses = state.classes;
              studentsx = state.attendances;
              setState(() {
                for (var element in returnedClasses) {
                  if (!classes.contains(element.className)) {
                    classes.add(element.className);
                  }
                }
                selectedClass = classes[0];
                selectedClassId = returnedClasses[0].classId;
                // studentsx = returnedAttendances;
                students = studentsx.map((s) => s.copy()).toList();
                // students = studentsx;
                // print(studentsx[0].attendanceModel);
                // print(studentsx[1].attendanceModel);
              });
            }
            if (state is ClassesLoaded2) {
              returnedClasses = state.classes;
              studentsx = state.attendances;
              setState(() {
                for (var element in returnedClasses) {
                  if (!classes.contains(element.className)) {
                    classes.add(element.className);
                  }
                }
                selectedClassId =
                    returnedClasses
                        .firstWhere(
                          (element) => element.className == selectedClass,
                        )
                        .classId;
                students = studentsx.map((s) => s.copy()).toList();
                // studentsx = returnedAttendances;
                // students = returnedAttendances;
              });
            }
          },
          builder: (context, state) {
            if (state is ClassesLoaded || state is ClassesLoaded2) {
              return SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  constraints: BoxConstraints(minHeight: screenHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Class dropdown
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class',
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
                                    value: selectedClass,
                                    items:
                                        classes.map((String value) {
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
                                      int classId =
                                          returnedClasses
                                              .firstWhere(
                                                (element) =>
                                                    element.className ==
                                                    newValue,
                                              )
                                              .classId;
                                      setState(() {
                                        // classes.clear();
                                        // students.clear();
                                        // returnedClasses.clear();

                                        BlocProvider.of<ClassesCubit>(
                                          context,
                                        ).getClassesx(classId);
                                        print(newValue);
                                        selectedClass = newValue!;
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ],
                              ),
                            ),

                            // Date selection
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Color(0xFFB6C8E2),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.04,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _selectDate,
                                    child: Container(
                                      width: double.infinity,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFB6C8E2),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat(
                                            'd/M/y',
                                          ).format(selectedDate),
                                          style: TextStyle(
                                            color: const Color(0xFF2F394B),
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.04,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Students table header
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Student',
                              style: TextStyle(
                                color: Color(0xFF0C46C4),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.02,
                              ),
                            ),
                            Text(
                              'Absent',
                              style: TextStyle(
                                color: Color(0xFF0C46C4),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.02,
                              ),
                            ),
                            Text(
                              'Present',
                              style: TextStyle(
                                color: Color(0xFF0C46C4),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          return _buildStudentAttendanceItem(
                            students[index],
                            index,
                          );
                        },
                      ),

                      // Save button
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0C46C4),
                            minimumSize: Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _saveAttendance,
                          child: Text(
                            'Save Attendance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Image.asset('assets/loading.gif'));
            }
          },
        ),
      ),
    );
  }

  getChecked(TeacherAttendanceForStudent student) {
    if (student.attendanceModel != null) {
      if (student.attendanceModel!.status == 'Present') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Widget _buildStudentAttendanceItem(
    TeacherAttendanceForStudent student,
    int index,
  ) {
    final isPresent = getChecked(student);
    // print(student.student.name);
    // print(student.attendanceModel!.classId);
    // print(isPresent);
    return Container(
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Student name
          Expanded(
            child: Text(
              student.student.name,
              style: TextStyle(
                color: const Color(0xFF495D80),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.04,
              ),
            ),
          ),

          // Present checkbox
          GestureDetector(
            onTap: () {
              DateTime now = DateTime.now();
              setState(() {
                students[index].attendanceModel = AttendanceModel(
                  id: 0,
                  date: '${now.year}-${now.month}-${now.day}',
                  status: 'Present',
                  name: student.student.name,
                  classId: selectedClassId!,
                );
              });
              // studentsx.forEach((i) => print(i.attendanceModel));
              // print('bbbbbbbbbbb');
              // students.forEach((i) => print(i.attendanceModel));
            },
            child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(left: 16),
              decoration: ShapeDecoration(
                color: isPresent ? Color(0xFF0C46C4) : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color:
                        isPresent ? Color(0xFF0C46C4) : const Color(0xFFB6C8E2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child:
                  isPresent
                      ? Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
            ),
          ),

          // Absent checkbox
          GestureDetector(
            onTap: () {
              // DateTime now = DateTime.now();
              setState(() {
                student.attendanceModel = null;
                // if (studentsx[index].attendanceModel == null) {
                //   student.attendanceModel = null;
                // } else {
                //   student.attendanceModel = AttendanceModel(
                //     id: studentsx[index].attendanceModel!.id,
                //     date: '${now.year}-${now.month}-${now.day}',
                //     status: 'Absent',
                //     name: student.student.name,
                //     classId: selectedClassId!,
                //   );
                // }

                // student.attendanceModel = AttendanceModel(
                //   id: 0,
                //   date: '${now.year}-${now.month}-${now.day}',
                //   status: 'Absent',
                //   name: student.student.name,
                //   classId: selectedClassId!,
                // );
              });
            },
            child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(left: 16),
              decoration: ShapeDecoration(
                color: !isPresent ? Color(0xFFF76565) : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color:
                        !isPresent
                            ? Color(0xFFF76565)
                            : const Color(0xFFB6C8E2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child:
                  !isPresent
                      ? Icon(Icons.close, size: 14, color: Colors.white)
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  getPresenys() {
    List<TeacherAttendanceForStudent> ss = [];
    for (var item in students) {
      if (item.attendanceModel != null &&
          item.attendanceModel!.status == 'Present') {
        ss.add(item);
      }
    }
    return ss.length;
    // return students
    //     .where((element) => element.attendanceModel!.status == 'Present')
    //     .toList()
    //     .length;
  }

  void _saveAttendance() {
    final presentCount = getPresenys();
    final absentCount = students.length - presentCount;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Confirm Attendance'),
            content: Text(
              'Attendance will be saved for:\n'
              'Class: $selectedClass\n'
              'Subject: $selectedSubject\n'
              'Date: ${DateFormat('d/M/y').format(selectedDate)}\n\n'
              'Present: $presentCount\n'
              'Absent: $absentCount',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  List<TeacherAttendanceForStudent> updated = [];
                  List<TeacherAttendanceForStudent> savedAbsent = [];
                  List<TeacherAttendanceForStudent> savedPresent = [];

                  for (int i = 0; i < students.length; i++) {
                    if (studentsx[i].attendanceModel == null &&
                        students[i].attendanceModel == null) {
                      savedAbsent.add(students[i]);
                    } else if (studentsx[i].attendanceModel == null &&
                        students[i].attendanceModel != null &&
                        students[i].attendanceModel!.status == 'Present') {
                      savedPresent.add(students[i]);
                    } else if (studentsx[i].attendanceModel != null) {
                      if (students[i].attendanceModel == null) {
                        updated.add(studentsx[i]);
                      } else if (studentsx[i].attendanceModel!.status !=
                          students[i].attendanceModel!.status) {
                        updated.add(studentsx[i]);
                      }
                    }
                  }
                  BlocProvider.of<ClassesCubit>(context).saveAttendance(
                    updated,
                    savedAbsent,
                    savedPresent,
                    selectedClassId!,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Attendance saved successfully')),
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

class StudentAttendance {
  String name;
  bool? isPresent;

  StudentAttendance({required this.name, this.isPresent});
}
