import 'package:flutter/material.dart';

class TeacherResultView extends StatefulWidget {
  const TeacherResultView({super.key});
  static final String id = 'teacher_result_view';

  @override
  State<TeacherResultView> createState() => _TeacherResultViewState();
}

class _TeacherResultViewState extends State<TeacherResultView> {
  // بيانات الفصل والطلاب
  String selectedClass = 'Class 1';
  String selectedTerm = 'First';
  String selectedSubject = 'Math';
  
  // قوائم الاختيارات
  final List<String> classes = ['Class 1', 'Class 2', 'Class 3', 'Class 4'];
  final List<String> terms = ['First', 'Second'];
  final List<String> subjects = ['English', 'Arabic','Science','Math','History' ];
  
  // قائمة الطلاب ودرجاتهم
  List<StudentResult> students = [
    StudentResult(name: 'Mohamed Ashraf'   , grade: 0, total: 100),
    StudentResult(name: 'Ahmed Ali'       , grade: 0, total: 100),
    StudentResult(name: 'Sara Mohamed'    , grade: 0, total: 100),
    StudentResult(name: 'Youssef Hassan'   , grade: 0, total: 100),
    StudentResult(name: 'Fatima Mahmoud'   , grade: 0, total: 100),
    StudentResult(name: 'Omar Khaled'     , grade: 0, total: 100),
    StudentResult(name: 'Lina Samir'      , grade: 0, total: 100),
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
           
              // أيقونة العودة
              Positioned(
                left: 18,
                top: 55,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                ),
              ),
              
              // عنوان الصفحة
              Positioned(
                left: 139,
                top: 55,
                child: Text(
                  'change results',
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
                left: 16,
                top: 98,
                child: Text(
                  'Term',
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
                left: 16,
                top: 119,
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
              
              // معلومات الفصل الدراسي
              Positioned(
                left: 128,
                top: 98,
                child: Text(
                  'Class',
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
                left: 128,
                top: 119,
                child: DropdownButton<String>(
                  value: selectedTerm,
                  items: terms.map((String value) {
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
                    });
                  },
                  underline: Container(),
                ),
              ),
              
              // معلومات المادة
              Positioned(
                left: 240,
                top: 98,
                child: Text(
                  'Subject',
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
                left: 240,
                top: 119,
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
              
              // عنوان جدول الطلاب
              Positioned(
                left: 0,
                top: 177,
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
                            color: Color(0xFF2F394B),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                        Text(
                          'grades',
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
              ),
              
              // قائمة الطلاب
              Positioned(
                top: 233,
                bottom: 80,
                left: 0,
                right: 0,
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return _buildStudentItem(students[index], index);
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentItem(StudentResult student, int index) {
    final isEven = index % 2 == 0;
    final textColor = student.grade >= 50 ? Color(0xFF0C46C4) : Color(0xFFF76565);
    
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
    final gradeController = TextEditingController(text: student.grade.toString());
    final totalController = TextEditingController(text: student.total.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Grade for ${student.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: gradeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Grade',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newGrade = int.tryParse(gradeController.text) ?? student.grade;
              final newTotal = int.tryParse(totalController.text) ?? student.total;
              
              setState(() {
                student.grade = newGrade;
                student.total = newTotal;
              });
              
              Navigator.pop(context);
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }

  void _saveResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save Changes'),
        content: Text('Are you sure you want to save changes for ${students.length} students?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Changes saved successfully')),
              );
              // هنا يمكنك إضافة كود لحفظ البيانات في قاعدة البيانات
            },
            child: Text('confirm'),
          ),
        ],
      ),
    );
  }
}

class StudentResult {
  String name;
  int grade;
  int total;
  
  StudentResult({
    required this.name,
    required this.grade,
    required this.total,
  });
}