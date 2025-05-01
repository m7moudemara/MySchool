import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherAttendanceView extends StatefulWidget {
  const TeacherAttendanceView({super.key});
  static const String id = "/TeacherAttendanceView";
  
  @override
  State<TeacherAttendanceView> createState() => _TeacherAttendanceViewState();
}

class _TeacherAttendanceViewState extends State<TeacherAttendanceView> {
  // Class data
  String selectedClass = 'Class 1';
  String selectedSubject = 'English';
  DateTime selectedDate = DateTime.now();
  
  // Dropdown options
  final List<String> classes = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];
  
  // Students list and attendance status
  List<StudentAttendance> students = [
    StudentAttendance(name: 'Mohamed Ashraf'),
    StudentAttendance(name: 'Ahmed Ali'),
    StudentAttendance(name: 'Sara Mohamed'),
    StudentAttendance(name: 'Youssef Hassan'),
    StudentAttendance(name: 'Fatima Mahmoud'),
    StudentAttendance(name: 'Omar Khaled'),
    StudentAttendance(name: 'Lina Samir'),
  ];

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
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
         
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                              items: classes.map((String value) {
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
                                    borderRadius: BorderRadius.circular(3),
                                ),
                                ),
                                child: Center(
                                  child: Text(
                                    DateFormat('d/M/y').format(selectedDate),
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
                
                // Students list
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentAttendanceItem(students[index]);
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
        ),
      ),
    );
  }

  Widget _buildStudentAttendanceItem(StudentAttendance student) {
    final isPresent = student.isPresent ?? false;
    
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
              student.name,
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
              setState(() {
                student.isPresent = true;
              });
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
                    color: isPresent ? Color(0xFF0C46C4) : const Color(0xFFB6C8E2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: isPresent
                  ? Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          
          // Absent checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                student.isPresent = false;
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
                    color: !isPresent ? Color(0xFFF76565) : const Color(0xFFB6C8E2),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: !isPresent
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

  void _saveAttendance() {
    final presentCount = students.where((s) => s.isPresent ?? false).length;
    final absentCount = students.length - presentCount;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Attendance'),
        content: Text('Attendance will be saved for:\n'
                     'Class: $selectedClass\n'
                     'Subject: $selectedSubject\n'
                     'Date: ${DateFormat('d/M/y').format(selectedDate)}\n\n'
                     'Present: $presentCount\n'
                     'Absent: $absentCount'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
  
  StudentAttendance({
    required this.name,
    this.isPresent,
  });
}