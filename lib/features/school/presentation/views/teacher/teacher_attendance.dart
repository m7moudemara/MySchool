import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherAttendanceView extends StatefulWidget {
  const TeacherAttendanceView({super.key});
  static const String id = "/TeacherAttendanceView";
  @override
  State<TeacherAttendanceView> createState() => _TeacherAttendanceViewState();
}

class _TeacherAttendanceViewState extends State<TeacherAttendanceView> {
  // بيانات الفصل والطلاب
  String selectedClass = 'Class 1';
  String selectedSubject = 'English';
  DateTime selectedDate = DateTime.now();
  
  // قوائم الاختيارات
  final List<String> classes =  ['Class 1', 'Class 2', 'Class 3', 'Class 4'];
  final List<String> subjects = ['English', 'Arabic','Science','Math','History' ];
  
  // قائمة الطلاب وحالات حضورهم
  List<StudentAttendance> students = [
    StudentAttendance(name: 'Mohamed Ashraf'   ),
    StudentAttendance(name: 'Ahmed Ali'       ),
    StudentAttendance(name: 'Sara Mohamed'   ),
    StudentAttendance(name:'Youssef Hassan' ),
    StudentAttendance(name:'Fatima Mahmoud'  ),
    StudentAttendance(name: 'Omar Khaled'   ),
    StudentAttendance(name:'Lina Samir'           ),
  ];
  
    



 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: 360,
          height: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Stack(
            children: [
         
              // عنوان الصفحة
              Positioned(
                left: 116,
                top: 54,
                child: Text(
                  'تسجيل الحضور',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              
              // معلومات الفصل
              Positioned(
                left: 17,
                top: 95,
                child: Text(
                  'الصف',
                  style: TextStyle(
                    color: Color(0xFFB6C8E2),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 116,
                child: DropdownButton<String>(
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
              ),
              
              // معلومات المادة
              Positioned(
                left: 114,
                top: 95,
                child: Text(
                  'subject',
                  style: TextStyle(
                    color: Color(0xFFB6C8E2),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                  ),
                ),
              ),
              Positioned(
                left: 114,
                top: 116,
                child: DropdownButton<String>(
                  value: selectedSubject,
                  items: subjects.map((String value) {
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
                    });
                  },
                  underline: Container(),
                ),
              ),
              
              // معلومات التاريخ
              Positioned(
                left: 235,
                top: 95,
                child: Text(
                  'date',
                  style: TextStyle(
                    color: Color(0xFFB6C8E2),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                  ),
                ),
              ),
              Positioned(
                left: 235,
                top: 116,
                child: GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    width: 110,
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
              ),
              
              // عنوان جدول الطلاب
              Positioned(
                left: 0,
                top: 148,
                child: Container(
                  width: 360,
                  height: 56,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
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
                          'absent',
                          style: TextStyle(
                            color: Color(0xFF0C46C4),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                        Text(
                          'atend',
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
                ),
              ),
              
              // قائمة الطلاب
              Positioned(
                top: 204,
                bottom: 80,
                left: 0,
                right: 0,
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentAttendanceItem(students[index]);
                  },
                ),
              ),
              
              // زر الحفظ
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0C46C4),
                    padding: EdgeInsets.symmetric(vertical: 16),
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
    );
  }

  Widget _buildStudentAttendanceItem(StudentAttendance student) {
    return Container(
      width: 360,
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // اسم الطالب
          Positioned(
            left: 16,
            top: 17,
            child: SizedBox(
              width: 180,
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
          ),
          
          // زر الحضور
          Positioned(
            left: 221,
            top: 17,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  student.isPresent = true;
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: student.isPresent ? Color(0xFF0C46C4) : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: student.isPresent ? Color(0xFF0C46C4) : const Color(0xFFB6C8E2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: student.isPresent 
                    ? Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ),
          ),
          
          // زر الغياب
          Positioned(
            left: 298,
            top: 17,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  student.isPresent = false;
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: !student.isPresent ? Color(0xFFF76565) : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: !student.isPresent ? Color(0xFFF76565) : const Color(0xFFB6C8E2),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: !student.isPresent 
                    ? Icon(Icons.close, size: 14, color: Colors.white)
                    : null,
              ),
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
    final presentCount = students.where((s) => s.isPresent).length;
    final absentCount = students.length - presentCount;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد حفظ الحضور'),
        content: Text('سيتم حفظ بيانات الحضور لـ:\n'
                     'الصف: $selectedClass\n'
                     'المادة: $selectedSubject\n'
                     'التاريخ: ${DateFormat('d/M/y').format(selectedDate)}\n\n'
                     'عدد الحاضرين: $presentCount\n'
                     'عدد الغائبين: $absentCount'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم حفظ بيانات الحضور بنجاح')),
              );
              // هنا يمكنك إضافة كود لحفظ البيانات في قاعدة البيانات
            },
            child: Text('تأكيد الحفظ'),
          ),
        ],
      ),
    );
  }
}

class StudentAttendance {
  String name;
  bool isPresent;
  
  StudentAttendance({
    required this.name,
    this.isPresent = true, // افتراضيًا حاضر
  });
}